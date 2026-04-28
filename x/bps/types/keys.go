package types

import "cosmossdk.io/collections"

const (
	// ModuleName defines the module name
	ModuleName = "bps"

	// StoreKey defines the primary module store key
	StoreKey = ModuleName

	// GovModuleName duplicates the gov module's name to avoid a dependency with x/gov.
	// It should be synced with the gov module's name if it is ever changed.
	// See: https://github.com/cosmos/cosmos-sdk/blob/v0.52.0-beta.2/x/gov/types/keys.go#L9
	GovModuleName = "gov"
)

var legacyParamsPrefix = string([]byte{0x70, 0x5f, 0x73, 0x65, 0x6d, 0x61, 0x72})

// ParamsKey is the prefix to retrieve all Params.
// Keep legacy prefix for existing chain state compatibility.
var ParamsKey = collections.NewPrefix(legacyParamsPrefix)
