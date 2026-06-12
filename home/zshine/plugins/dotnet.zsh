[[ $commands[dotnet] ]] || return

path=($path ~/.dotnet/tools)

export DOTNET_CLI_TELEMETRY_OPTOUT=1
