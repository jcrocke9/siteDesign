#$creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
$Url = "https://alexandriava1.sharepoint.com/sites/pwa"
#Connect-SPOService -Url $adminUrl -Credential $creds

function Set-CoaPnpTheme ()
{
    Add-PnPFile -Path .\fontscheme000_Alex.spfont -Folder "_catalogs/theme/15"
    Add-PnPFile -Path .\Palette000_Alex.spcolor -Folder "_catalogs/theme/15"
    $siteRelUrl = (Get-PnPWeb).ServerRelativeUrl
    $colorPaletteUrl = $siteRelUrl + "/_catalogs/theme/15/palette000_Alex.spcolor"
    $fontSchemeUrl = $siteRelUrl + "/_catalogs/theme/15/fontscheme000_Alex.spfont"
    Set-PnPTheme -ColorPaletteUrl $colorPaletteUrl -FontSchemeUrl $fontSchemeUrl
}

$UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
Start-Sleep -Seconds 1
Connect-PnPOnline -Url $Url -Credentials $creds
Set-CoaPnpTheme
$userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false
