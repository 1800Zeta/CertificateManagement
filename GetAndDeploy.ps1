
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
} else {
    Write-Output "Posh-ACME module is installed"
}

$configJSON = Get-Content CertificateConfig.json | ConvertFrom-Json
$cfTokenSecure = ConvertTo-SecureString $configJSON.cloudflareToken -AsPlainText -Force
$cfPluginArgs = @{ CFToken = $cfTokenSecure}
$domains = $configJSON.certificateNames

try {
    $existingCert = Get-PACertificate
    if($null -eq $existingCert)
    {
        # Certs are empty to need to trigger create
    }
    $allSANs = $existingCert.allSANs
    Write-Output "Found $allSANs"
    Write-Output "Check $domains"
    if($allSans -eq $domains)
    {
        # Certificate Found
        Write-Output "Matching Certificate found"
    }
}
catch {
    $newPACertParams = @{
        Domain     = $domains
        DnsPlugin  = "Cloudflare"
        PluginArgs = $cfPluginArgs
        Contact    = $configJSON.emailNotifications
        AcceptTOS  = $null
    }
    New-PACertificate $newPACertParams
}
