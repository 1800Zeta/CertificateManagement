
$ModuleInstalled = Get-Module Posh-ACME
if($null -eq $ModuleInstalled){
    Write-Output "Posh-ACME module is NOT installed, proceeding with install"
    Install-Module Posh-ACME -Confirm:$false
}
else {
    Write-Output "Posh-ACME module is installed"
}