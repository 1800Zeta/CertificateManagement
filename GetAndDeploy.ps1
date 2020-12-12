
try{
    Get-Module Posh-ACME
    Write-Output "Posh-ACME module is installed"
}
catch {
    Install-Module Posh-ACME -SkipPublisherCheck
}