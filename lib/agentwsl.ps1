Import-Module $PSScriptRoot\agentmodule.psm1

Start-Agent -UseWsl
Assert-AgentRunning -UseWsl

Write-Host "Agent started at WSL_SSH_AUTH_SOCK=$env:WSL_SSH_AUTH_SOCK"
Write-Host "Cloned to SSH_AUTH_SOCK"
$env:SSH_AUTH_SOCK = $env:WSL_SSH_AUTH_SOCK

$env:WSLENV += ":SSH_AUTH_SOCK/p"
wsl

Write-Host "Closing agent..."