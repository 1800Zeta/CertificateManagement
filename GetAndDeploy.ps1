
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
$domains = $configJSON.certificateNames

try {
    $existingCerts = Get-PACertificate
    foreach($existingCert in $existingCerts)
    {
        $allSANs = $existingCert.$allSANs
        if($domains -eq $allSANs)
        {
            # Certificate Found
            Write-Output "Matching Certificate found"
        }
    }
}
catch {
    $newPACertParams = @{
        Domain     = $domains
        DnsPlugin  = "Cloudflare"
        PluginArgs = $cfPluginArgs
        Contact    = $configJSON.emailNotifications
        AcceptTOS  = $true
    }
    New-PACertificate $newPACertParams
}
