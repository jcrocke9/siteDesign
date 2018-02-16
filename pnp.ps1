Add-PnPFile -Path .\fontscheme000_Alex.spfont -Folder "_catalogs/theme/15"
Add-PnPFile -Path .\Palette000_Alex.spcolor -Folder "_catalogs/theme/15"

$siteRelUrl = "/sites/boardsqa"
$colorPaletteUrl = $siteRelUrl + "/_catalogs/theme/15/palette000_Alex.spcolor"
$fontSchemeUrl = $siteRelUrl + "/_catalogs/theme/15/fontscheme000_Alex.spfont"
Set-PnPTheme -ColorPaletteUrl $colorPaletteUrl -FontSchemeUrl $fontSchemeUrl
