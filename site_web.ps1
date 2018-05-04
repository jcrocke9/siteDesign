Import-Module Microsoft.Online.SharePoint.PowerShell
$creds = Get-Credential

# Get-SPOSite -Identity "https://alexandriava1.sharepoint.com/sites/its"
Connect-PnPOnline -Url "https://alexandriava1.sharepoint.com/sites/its" -Credentials $creds
Get-PnPWeb 
