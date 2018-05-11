# Import-Module SharePointPnPPowerShellOnline
# Import-Module Microsoft.Online.SharePoint.PowerShell
# $creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl -Credential $creds
$TemplateWorkingOnNow = "GROUP#0"

function Get-CoaPnpGroupTheme () {
    $Theme = (Get-PnPTheme).Theme
    $CompDetails = New-Object psobject -Property @{
        Url        = $Url
        Theme      = $Theme
    }
    $CompDetails | Export-Csv -Path C:\alex\out\siteDesign_group_theme_ITS.csv -Append -NoClobber -NoTypeInformation
    Clear-Variable Theme
    Clear-Variable Url
}


function Set-CoaPnpGroupTheme ([psobject]$SubWebConnection)
{
    Set-PnPWebTheme -Theme "AlexBlue" -Connection $SubWebConnection
}

Get-SPOSite -Template "GROUP#0" -Limit ALL | Where-Object {($_.Url -clike "*ITS*") -or ($_.Url -Clike "*IT*") -or ($_.Url -like "*swu17*") -or ($_.Url -like "*eppm*")} | ForEach-Object { 
    $Url = $_.Url # ""
    $Url
    $UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
    Start-Sleep -Seconds 1
    $Connection = Connect-PnPOnline -Url $Url -Credentials $creds -ReturnConnection
    Get-CoaPnpGroupTheme
    Set-CoaPnpGroupTheme ($Connection)
    $userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false
}