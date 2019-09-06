$url = 'https://github.com/benpye/wsl-ssh-pageant/releases/latest/download/wsl-ssh-pageant-amd64.exe';

cd $PSScriptRoot;
#wget $url -OutFile wsl-ssh-pageant-amd64.exe
curl.exe -LOJ $url;