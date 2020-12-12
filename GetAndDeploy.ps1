$nugetVersion = Get-PackageProvider -Name NuGet
if($nugetVersion.Version -lt "3.0.0.1"){
    Write-Output "NuGet needs an update"
}
else {
    Write-Output "NuGet is up to date"
}

$moduleInstalled = Get-Module Posh-ACME
if($null -eq $moduleInstalled){
    Write-Output "Posh-ACME module is NOT installed, proceeding with install"
    Install-Module Posh-ACME -Force -Scope CurrentUser
}
else {
    Write-Output "Posh-ACME module is installed"
}