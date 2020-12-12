
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
    Install-Module Posh-ACME -Force
} else {
    Write-Output "Posh-ACME module is installed"
}

$configJSON = Get-Content CertificateConfig.json | ConvertFrom-Json

$cfTokenSecure = ConvertTo-SecureString $configJSON.cloudflareToken -AsPlainText -Force
$cfPluginArgs = @{ CFToken = $cfTokenSecure}

New-PACertificate -Domain $configJSON.certificateNames -DnsPlugin Cloudflare -PluginArgs $cfPluginArgs -AcceptTOS -Contact $configJSON.emailNotifications
Write-Output "Certificate Names are " $configJSON.certificateNames
Write-Output "Emails sent to " $configJSON.emailNotifications
Write-Output "Cloudflare token " $configJSON.cloudflareToken