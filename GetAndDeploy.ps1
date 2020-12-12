$psRepository = Get-PSRepository -Name PSGallery
if($psRepository.InstallationPolicy -eq "Untrusted"){
    Write-Output "PSGallery is Untrusted"
    Set-PSRepository $psRepository -InstallationPolicy Trusted
}
else {
    Write-Output "PSGallery is trusted"
}

$moduleInstalled = Get-Module Posh-ACME
if($null -eq $moduleInstalled){
    Write-Output "Posh-ACME module is NOT installed, proceeding with install"
    Install-Module Posh-ACME -Force -Scope CurrentUser -SkipPublisherCheck
}
else {
    Write-Output "Posh-ACME module is installed"
}