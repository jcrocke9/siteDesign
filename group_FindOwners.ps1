Import-Module AzureADPreview
Import-Module Microsoft.Online.SharePoint.PowerShell
Connect-SPOService -Url https://alexandriava1-admin.sharepoint.com
Connect-AzureAD
$WarningDate = (Get-Date).AddDays(-90)
$Today = (Get-Date)

$groupInfo = @()
Get-AzureADMSGroup -All:$true | where-object {$_.GroupTypes -like "*Unified*"} | foreach-object {
    $id = $_.Id
    $name = $_.DisplayName
    $owner = @()
    [string[]]$ownerStr
    Clear-Variable ownerStr -ErrorAction SilentlyContinue
    $owner = (Get-AzureADGroupOwner -ObjectId $id).UserPrincipalName
    $owner | ForEach-Object {
        [string]$ownerToString = $_ + ";"
        $ownerStr += $ownerToString
    }
    #region
    # this needs to have exchange, because it pulls it from UnifiedGroup cmdlet
    $ExoGroupObj = Get-UnifiedGroup -Identity $name
    $ExoSpoUrl = $ExoGroupObj.SharePointDocumentsUrl
    [string]$SpoSiteStatus
    $AuditRecs = 0
    [string]$AuditRecsDate
    Clear-Variable SpoSiteStatus -ErrorAction SilentlyContinue
    Clear-Variable AuditRecs -ErrorAction SilentlyContinue
    Clear-Variable AuditRecsDate -ErrorAction SilentlyContinue
    If ($ExoGroupObj.SharePointDocumentsUrl -ne $Null)
    {
        $SPOSite = (Get-SPOSite -Identity $ExoGroupObj.SharePointDocumentsUrl.replace("/Shared Documents", ""))
        Write-Host "Checking" $SPOSite.Title "..."
        $AuditCheck = $ExoGroupObj.SharePointDocumentsUrl + "/*"
        $AuditRecs = (Search-UnifiedAuditLog -RecordType SharePointFileOperation -StartDate $WarningDate -EndDate $Today -ObjectId $AuditCheck -SessionCommand ReturnNextPreviewPage)
        If ($AuditRecs -eq $null)
        {
            $SpoSiteStatus = "Probably Obsolete"
        }
        Else
        {
            $SpoSiteStatus = "In Use"
            $AuditRecsDate = $AuditRecs.CreationDate[0]
        }
    }
    Else
    {
        $SpoSiteStatus = "Obsolete"
    }
    #endregion
    $group = New-Object psobject -Property @{
        Id          = $id
        DisplayName = $name
        Owner       = $ownerStr
        AuditRecsDate = $AuditRecsDate
        SpoSiteStatus = $SpoSiteStatus
        SharePointUrl = $ExoSpoUrl
    }
    $groupInfo += $group
}
$groupInfo | Export-Csv -Path C:\alex\out\GroupInfo2.csv
