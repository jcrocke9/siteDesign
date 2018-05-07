Import-Module Microsoft.Online.SharePoint.PowerShell
Import-Module SharePointPnPPowerShellOnline
$creds = Get-Credential

# Get-SPOSite -Identity "https://alexandriava1.sharepoint.com/sites/its"
Connect-PnPOnline -Url "https://alexandriava1.sharepoint.com/sites/demo" -Credentials $creds
Measure-PnPWeb -Recursive
