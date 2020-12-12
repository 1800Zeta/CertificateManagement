
$packageProviders = Get-PackageProvider -ListAvailable    

if($nugetVersion.Name -contains "Nuget"){
    Write-Output "NuGet is installed"
}
else {
    Write-Output "NuGet needs installing"
    Install-PackageProvider NuGet -Force
    #Import-PackageProvider NuGet
}

$moduleInstalled = Get-Module Posh-ACME
if($null -eq $moduleInstalled){
    Write-Output "Posh-ACME module is NOT installed, proceeding with install"
    Install-Module Posh-ACME -Force -Scope CurrentUser
}
else {
    Write-Output "Posh-ACME module is installed"
}