#$creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
$Url = "https://alexandriava1.sharepoint.com/sites/demo"
$BaseUrl = "https://alexandriava1.sharepoint.com"
Connect-SPOService -Url $adminUrl -Credential $creds

function Set-CoaPnpTheme ([psobject]$SubWebConnection)
{
    Add-PnPFile -Connection $SubWebConnection -Path .\fontscheme000_Alex.spfont -Folder "_catalogs/theme/15"
    Add-PnPFile -Connection $SubWebConnection -Path .\Palette000_Alex.spcolor -Folder "_catalogs/theme/15"
    Add-PnPFile -Connection $SubWebConnection -Path .\CitySeal.png -Folder "SiteAssets"
    $siteRelUrl = (Get-PnPWeb -Connection $SubWebConnection).ServerRelativeUrl
    $colorPaletteUrl = $siteRelUrl + "/_catalogs/theme/15/palette000_Alex.spcolor"
    $fontSchemeUrl = $siteRelUrl + "/_catalogs/theme/15/fontscheme000_Alex.spfont"
    $siteLogoUrl = $siteRelUrl + "/SiteAssets/CitySeal.png"
    Set-PnPTheme -ColorPaletteUrl $colorPaletteUrl -FontSchemeUrl $fontSchemeUrl -Connection $SubWebConnection -ResetSubwebsToInherit
    Set-PnPWeb -SiteLogoUrl $siteLogoUrl
    Clear-Variable siteRelUrl
}

$UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
Start-Sleep -Seconds 1
$Connection = Connect-PnPOnline -Url $Url -Credentials $creds -ReturnConnection
Set-CoaPnpTheme ($Connection)
<# Get-PnPSubWebs -Recurse -Connection $Connection | ForEach-Object {
    $CurrentSubWeb = $BaseUrl + $_.ServerRelativeUrl
    $CurrentSubWeb
    $SubWebConnection = Connect-PnPOnline -Url $CurrentSubWeb -Credentials $creds -ReturnConnection
    Set-CoaPnpTheme ($SubWebConnection)
} #>
$userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false
