# $creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl -Credential $creds
$TemplateWorkingOnNow = "STS#0"
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


function Set-CoaPnpTheme ([psobject]$SubWebConnection)
{
    # Add-PnPFile -Connection $SubWebConnection -Path .\fontscheme000_Alex.spfont -Folder "_catalogs/theme/15"
    Add-PnPFile -Connection $SubWebConnection -Path .\Palette000_Alex.spcolor -Folder "_catalogs/theme/15"
    Add-PnPFile -Connection $SubWebConnection -Path .\CitySeal.png -Folder "SiteAssets"
    $siteRelUrl = (Get-PnPWeb -Connection $SubWebConnection).ServerRelativeUrl
    $colorPaletteUrl = $siteRelUrl + "/_catalogs/theme/15/palette000_Alex.spcolor"
    # $fontSchemeUrl = $siteRelUrl + "/_catalogs/theme/15/fontscheme000_Alex.spfont"
    $siteLogoUrl = $siteRelUrl + "/SiteAssets/CitySeal.png"
    Set-PnPTheme -Connection $SubWebConnection -ColorPaletteUrl $colorPaletteUrl  # -FontSchemeUrl $fontSchemeUrl -ResetSubwebsToInherit
    Set-PnPWeb -SiteLogoUrl $siteLogoUrl

    $getDate = Get-Date -Format "%Y%m%d"
    WriteToLog -logLineTime $getDate -writeTo "$siteRulUrl`tSuccess"
    Clear-Variable siteRelUrl
}

function Get-CoaSpoGroupTheme () {
    Get-PnPTheme
}

Get-SPOSite -Limit ALL | Where-Object {$_.Template -eq $TemplateWorkingOnNow} | ForEach-Object {
    $Url = $_.Url
    $Url
    $UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
    Start-Sleep -Seconds 1
    $Connection = Connect-PnPOnline -Url $Url -Credentials $creds -ReturnConnection
<#     Get-PnPSubWebs -Recurse -Connection $Connection | ForEach-Object {
        $CurrentSubWeb = $BaseUrl + $_.ServerRelativeUrl
        $CurrentSubWeb
        $SubWebConnection = Connect-PnPOnline -Url $CurrentSubWeb -Credentials $creds -ReturnConnection
        Set-CoaPnpTheme ($SubWebConnection)
    } #>
Set-CoaPnpTheme($Connection)
    # if ($TemplateWorkingOnNow = "STS#0") {Get-CoaSpoStsTheme}
    # if ($TemplateWorkingOnNow = "GROUP#0") {Get-CoaSpoGroupTheme}
    $userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false
}
