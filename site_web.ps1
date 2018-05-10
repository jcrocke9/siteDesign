# Import-Module Microsoft.Online.SharePoint.PowerShell
# Import-Module SharePointPnPPowerShellOnline
# $creds = Get-Credential
$getDate = Get-Date -Format "%Y%m%d%A%Z"
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
# Connect-SPOService -Url $adminUrl -Credential $creds
Clear-Variable sites
$sites = @()
Get-SPOSite -Limit ALL | ForEach-Object {
    $Url = $_.Url
    $Template = (Get-SPOSite -Identity $Url).Template
    $siteTemplate = New-Object psobject -Property @{
        Url = $Url
        Template = $Template
    }
    $sites += $siteTemplate
}
$sites | Export-Csv -Path "C:\alex\out\siteTemplates_$getDate.csv"
