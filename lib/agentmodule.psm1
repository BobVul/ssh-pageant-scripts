function Start-Agent {
    $guid = New-Guid;
    $pipename = "ssh-pageant-$guid";
    $command = Join-Path $PSScriptRoot 'wsl-ssh-pageant-amd64.exe';

    if (!(Test-Path $command)) {
        Write-Host -ForegroundColor Red "Could not find agent at $command. Have you run downloadagent?";
        Read-Host -Prompt "Press Enter to exit";
        exit;
    }

    $job = Start-Job {&$Using:command --winssh $Using:pipename};

    $pipepath = "\\.\pipe\$pipename";

    while (!(Test-Path $pipepath) -and $job.State -eq 'Running') {
        sleep 0.1;
        Receive-Job $job;
    }
    Receive-Job $job;

    $env:SSH_AUTH_SOCK = $pipepath;
}

function Assert-AgentRunning {
    if (!(Test-Path $env:SSH_AUTH_SOCK)) {
        Write-Host -ForegroundColor Red "Failed to start agent";
        Read-Host -Prompt "Press Enter to exit";
        exit;
    }
}