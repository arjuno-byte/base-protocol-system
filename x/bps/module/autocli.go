package bps

import autocliv1 "cosmossdk.io/api/cosmos/autocli/v1"

// AutoCLIOptions implements the autocli.HasAutoCLIConfig interface.
//
// Returning nil keeps the module functional while avoiding runtime
// panics caused by stale gogo descriptor metadata after namespace renames.
func (am AppModule) AutoCLIOptions() *autocliv1.ModuleOptions {
	return nil
}
