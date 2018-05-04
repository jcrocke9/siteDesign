$creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
# Connect-SPOService -Url $adminUrl -Credential $creds
# $TemplateWorkingOnNow = "STS#0"
# $TemplateWorkingOnNow = "GROUP#0"

function Get-CoaSpoStsTheme () {
    $Name = (Get-PnPTheme -DetectCurrentComposedLook).Name
    $MasterPage = (Get-PnPTheme -DetectCurrentComposedLook).MasterPage
    $Theme = (Get-PnPTheme -DetectCurrentComposedLook).Theme
    $CompDetails = New-Object psobject -Property @{
        Url        = $Url
        Name       = $Name
        MasterPage = $MasterPage
        Theme      = $Theme
    }
    $CompDetails | Export-Csv -Path C:\alex\out\siteDesign_sts_composedLook_tst.csv -Append -NoClobber -NoTypeInformation
    Clear-Variable Name
    Clear-Variable MasterPage
    Clear-Variable Theme
    Clear-Variable Url
}

function Get-CoaSpoGroupTheme () {
    Get-PnPTheme
}

Get-SPOSite -Limit ALL | Where-Object {$_.Template -eq $TemplateWorkingOnNow} | ForEach-Object {
    $Url = $_.Url
    $Url
    $UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
    Start-Sleep -Seconds 1
    Connect-PnPOnline -Url $Url -Credentials $creds
    if ($TemplateWorkingOnNow = "STS#0") {Get-CoaSpoStsTheme}
    if ($TemplateWorkingOnNow = "GROUP#0") {Get-CoaSpoGroupTheme}
    $userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false
}
