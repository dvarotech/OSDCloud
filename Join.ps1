$Domain = 'arrow.local'
$Credential = Get-Credential

Add-Computer -DomainName $Domain `
    -OUPath 'OU=Haydock,OU=Arrow-EndPoints,DC=arrow,DC=local' `
    -Credential $Credential -Force

gpupdate
gpupdate /sync

start-sleep 60
Restart-Computer
