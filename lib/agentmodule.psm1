function Start-Agent {
    param(
        [Switch] $UseWinssh,
        [Switch] $UseWsl
    )
    process {
        if (!$UseWinssh -and !$UseWsl) {
            $UseWinssh = $true;
        }

        $guid = New-Guid;
        $pipename = "ssh-pageant-$guid";
        $agentroot = Join-Path $PSScriptRoot 'agent';
        $command = Join-Path $agentroot 'wsl-ssh-pageant-amd64.exe';
        $cmdargs = @();

        if (!(Test-Path $command)) {
            Write-Host -ForegroundColor Red "Could not find agent at $command. Have you run downloadagent?";
            Read-Host -Prompt "Press Enter to exit";
            exit;
        }

        if ($UseWinssh) {
            $cmdargs += "--winssh", "$pipename";
        }
        if ($UseWsl) {
            $cmdargs += "--wsl", "$env:TEMP\$pipename";
        }

        $job = Start-Job {&$Using:command $Using:cmdargs};

        $winsshpipepath = "\\.\pipe\$pipename";
        $wslpipepath = "$env:TEMP\$pipename";

        while ((($UseWinssh -and !(Test-Path $winsshpipepath)) -or ($UseWsl -and !(Test-Path $wslpipepath))) -and $job.State -eq 'Running') {
            sleep 0.1;
            Receive-Job $job;
        }
        Receive-Job $job;

        if ($UseWinssh) {
            $env:SSH_AUTH_SOCK = $winsshpipepath;
        }
        if ($UseWsl) {
            $env:WSL_SSH_AUTH_SOCK = $wslpipepath;
        }
    }
}

function Assert-AgentRunning {
    param(
        [Switch] $UseWinssh,
        [Switch] $UseWsl
    )
    process {
        if (!$UseWinssh -and !$UseWsl) {
            $UseWinssh = $true;
        }
        
        if (($UseWinssh -and (!$env:SSH_AUTH_SOCK -or !(Test-Path $env:SSH_AUTH_SOCK))) -or
             ($UseWsl -and (!$env:WSL_SSH_AUTH_SOCK -or !(Test-Path $env:WSL_SSH_AUTH_SOCK)))
            ) {
            Write-Host -ForegroundColor Red "Failed to start agent";
            Read-Host -Prompt "Press Enter to exit";
            exit;
        }
    }
}