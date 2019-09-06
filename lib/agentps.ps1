Import-Module $PSScriptRoot\agentmodule.psm1

Start-Agent

Write-Host "Agent started at SSH_AUTH_SOCK=$env:SSH_AUTH_SOCK"

powershell

Write-Host "Closing agent..."