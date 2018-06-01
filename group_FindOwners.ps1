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
    [string]$SpoSiteStatus
    $AuditRecs = 0
    [string]$AuditRecsDate
    Clear-Variable SpoSiteStatus -ErrorAction SilentlyContinue
    Clear-Variable AuditRecs -ErrorAction SilentlyContinue
    Clear-Variable AuditRecsDate -ErrorAction SilentlyContinue
    If ($_.SharePointDocumentsUrl -ne $Null)
    {
        $SPOSite = (Get-SPOSite -Identity $_.SharePointDocumentsUrl.replace("/Shared Documents", ""))
        Write-Host "Checking" $SPOSite.Title "..."
        $AuditCheck = $_.SharePointDocumentsUrl + "/*"
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
    }
    $groupInfo += $group
}
$groupInfo | Export-Csv -Path C:\alex\out\GroupInfo1.csv
