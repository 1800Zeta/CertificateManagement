
$packageProviders = Get-PackageProvider -ListAvailable    

if($packageProviders.Name -contains "Nuget"){
    Write-Output "NuGet is installed"
}
else {
    Write-Output "NuGet needs installing"
    Install-PackageProvider NuGet -Force
}

$moduleInstalled = Get-Module Posh-ACME
if($null -eq $moduleInstalled){
    Write-Output "Posh-ACME module is NOT installed, proceeding with install"
    Install-Module Posh-ACME -Force -Scope CurrentUser
}
else {
    Write-Output "Posh-ACME module is installed"
}

$configJSON = ConvertFrom-Json (Get-Content CertificateConfig.json)

Write-Output "Certificate Names are " $configJSON.certificateNames