Import-Module $PSScriptRoot\agentmodule.psm1

Start-Agent

Write-Host "Agent started at SSH_AUTH_SOCK=$env:SSH_AUTH_SOCK"

code

Read-Host -Prompt "Press Enter to exit (and close the agent)"

Write-Host "Closing agent..."