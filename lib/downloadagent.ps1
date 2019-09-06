$baseurl = 'https://github.com/benpye/wsl-ssh-pageant/releases/latest/download/';
$files = @('wsl-ssh-pageant-amd64.exe', 'LICENSE');

$agentroot = Join-Path $PSScriptRoot 'agent';
mkdir -Force $agentroot;
cd $agentroot;
#wget $url -OutFile wsl-ssh-pageant-amd64.exe
foreach ($file in $files) {
    curl.exe -LOJ "$baseurl$file";
}