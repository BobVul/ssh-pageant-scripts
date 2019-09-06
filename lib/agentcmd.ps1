Import-Module $PSScriptRoot\agentmodule.psm1

Start-Agent
Assert-AgentRunning

Write-Host "Agent started at SSH_AUTH_SOCK=$env:SSH_AUTH_SOCK"

cmd

Write-Host "Closing agent..."