Import-Module Microsoft.Online.SharePoint.PowerShell
Import-Module SharePointPnPPowerShellOnline
$creds = Get-Credential

# Get-SPOSite -Identity "https://alexandriava1.sharepoint.com/sites/its"
Connect-PnPOnline -Url "https://alexandriava1.sharepoint.com/sites/demo" -Credentials $creds
Get-PnPSubWebs -Recurse | ForEach-Object {
    # $RelativeUrl = $_.ServerRelativeUrl
    Get-PnPWeb -Identity $_
}
