package app

import (
	"testing"

	sdkmath "cosmossdk.io/math"

	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/stretchr/testify/require"
)

func TestClampMintToHardCap(t *testing.T) {
	t.Run("no cap config keeps requested mint", func(t *testing.T) {
		minted := sdk.NewCoin("ubps", sdkmath.NewInt(100))
		got := clampMintToHardCap(sdkmath.NewInt(1_000), minted, "", sdkmath.ZeroInt())
		require.Equal(t, minted, got)
	})

	t.Run("different denom not capped", func(t *testing.T) {
		minted := sdk.NewCoin("utoken", sdkmath.NewInt(250))
		got := clampMintToHardCap(sdkmath.NewInt(1_000), minted, "ubps", sdkmath.NewInt(10_000))
		require.Equal(t, minted, got)
	})

	t.Run("at cap mints zero", func(t *testing.T) {
		minted := sdk.NewCoin("ubps", sdkmath.NewInt(999))
		got := clampMintToHardCap(sdkmath.NewInt(10_000), minted, "ubps", sdkmath.NewInt(10_000))
		require.Equal(t, sdkmath.ZeroInt(), got.Amount)
		require.Equal(t, "ubps", got.Denom)
	})

	t.Run("near cap mints remaining only", func(t *testing.T) {
		minted := sdk.NewCoin("ubps", sdkmath.NewInt(500))
		got := clampMintToHardCap(sdkmath.NewInt(9_800), minted, "ubps", sdkmath.NewInt(10_000))
		require.Equal(t, sdkmath.NewInt(200), got.Amount)
		require.Equal(t, "ubps", got.Denom)
	})

	t.Run("below cap keeps full block provision", func(t *testing.T) {
		minted := sdk.NewCoin("ubps", sdkmath.NewInt(100))
		got := clampMintToHardCap(sdkmath.NewInt(5_000), minted, "ubps", sdkmath.NewInt(10_000))
		require.Equal(t, minted, got)
	})
}
