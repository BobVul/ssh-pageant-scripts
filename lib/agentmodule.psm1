function Start-Agent {
    $guid = New-Guid;
    $sockname = "ssh-pageant-$guid";
    $command = Join-Path $PSScriptRoot 'wsl-ssh-pageant-amd64.exe';
    Start-Job {&$Using:command --winssh $Using:sockname} > $null;
    $env:SSH_AUTH_SOCK = "\\.\pipe\$sockname";
}