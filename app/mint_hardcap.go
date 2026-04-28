package app

import (
	"cosmossdk.io/depinject"
	sdkmath "cosmossdk.io/math"

	"github.com/cosmos/cosmos-sdk/telemetry"
	sdk "github.com/cosmos/cosmos-sdk/types"
	bankkeeper "github.com/cosmos/cosmos-sdk/x/bank/keeper"
	mintkeeper "github.com/cosmos/cosmos-sdk/x/mint/keeper"
	minttypes "github.com/cosmos/cosmos-sdk/x/mint/types"
)

const (
	// MintHardCapDenom is the denomination with max supply enforced by the mint logic.
	MintHardCapDenom = "ubps"
)

var (
	// 100,000,000 BPS * 1,000,000 ubps.
	MintHardCapAmount = sdkmath.NewInt(100_000_000_000_000)
)

type hardCapMintFnInputs struct {
	depinject.In

	BankKeeper bankkeeper.Keeper
}

type hardCapMintFnOutputs struct {
	depinject.Out

	MintFn mintkeeper.MintFn
}

// ProvideHardCapMintFn injects a custom mint function for enforcing max supply on-chain.
func ProvideHardCapMintFn(in hardCapMintFnInputs) hardCapMintFnOutputs {
	return hardCapMintFnOutputs{
		MintFn: NewHardCapMintFn(in.BankKeeper, MintHardCapDenom, MintHardCapAmount),
	}
}

// NewHardCapMintFn returns a mint function that applies the standard inflation flow
// and hard-clamps minted coins so total supply never exceeds capAmount for capDenom.
func NewHardCapMintFn(bankKeeper bankkeeper.Keeper, capDenom string, capAmount sdkmath.Int) mintkeeper.MintFn {
	return func(ctx sdk.Context, k *mintkeeper.Keeper) error {
		// fetch stored minter & params
		minter, err := k.Minter.Get(ctx)
		if err != nil {
			return err
		}

		params, err := k.Params.Get(ctx)
		if err != nil {
			return err
		}

		// recalculate inflation rate
		totalStakingSupply, err := k.StakingTokenSupply(ctx)
		if err != nil {
			return err
		}

		bondedRatio, err := k.BondedRatio(ctx)
		if err != nil {
			return err
		}

		minter.Inflation = minttypes.DefaultInflationCalculationFn(ctx, minter, params, bondedRatio)
		minter.AnnualProvisions = minter.NextAnnualProvisions(params, totalStakingSupply)
		if err = k.Minter.Set(ctx, minter); err != nil {
			return err
		}

		// mint coins with hard-cap enforcement
		mintedCoin := minter.BlockProvision(params)
		currentSupply := bankKeeper.GetSupply(ctx, capDenom).Amount
		mintedCoin = clampMintToHardCap(currentSupply, mintedCoin, capDenom, capAmount)

		if mintedCoin.Amount.IsPositive() {
			mintedCoins := sdk.NewCoins(mintedCoin)
			if err = k.MintCoins(ctx, mintedCoins); err != nil {
				return err
			}

			// send the minted coins to the fee collector account
			if err = k.AddCollectedFees(ctx, mintedCoins); err != nil {
				return err
			}
		}

		if mintedCoin.Amount.IsInt64() {
			defer telemetry.ModuleSetGauge(minttypes.ModuleName, float32(mintedCoin.Amount.Int64()), "minted_tokens")
		}

		ctx.EventManager().EmitEvent(
			sdk.NewEvent(
				minttypes.EventTypeMint,
				sdk.NewAttribute(minttypes.AttributeKeyBondedRatio, bondedRatio.String()),
				sdk.NewAttribute(minttypes.AttributeKeyInflation, minter.Inflation.String()),
				sdk.NewAttribute(minttypes.AttributeKeyAnnualProvisions, minter.AnnualProvisions.String()),
				sdk.NewAttribute(sdk.AttributeKeyAmount, mintedCoin.Amount.String()),
			),
		)

		return nil
	}
}

func clampMintToHardCap(currentSupply sdkmath.Int, mintedCoin sdk.Coin, capDenom string, capAmount sdkmath.Int) sdk.Coin {
	if !mintedCoin.Amount.IsPositive() {
		return mintedCoin
	}
	if capDenom == "" || !capAmount.IsPositive() {
		return mintedCoin
	}
	if mintedCoin.Denom != capDenom {
		return mintedCoin
	}
	if currentSupply.GTE(capAmount) {
		return sdk.NewCoin(mintedCoin.Denom, sdkmath.ZeroInt())
	}

	remaining := capAmount.Sub(currentSupply)
	if mintedCoin.Amount.GT(remaining) {
		return sdk.NewCoin(mintedCoin.Denom, remaining)
	}
	return mintedCoin
}
