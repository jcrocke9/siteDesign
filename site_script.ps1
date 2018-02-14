$site_script = @'
{
 "$schema": "schema.json",
     "actions": [
         {
             "verb": "applyTheme",
             "theme": "Alex2"
         },
         {
             "verb": "setSiteLogo",
             "url": "/SiteAssets/alexandria-seal.png"
         }
     ],
         "bindata": { },
 "version": 1
}
'@

$id = Add-SPOSiteScript -Title "City Team Site" -Content $site_script -Description "Themed for City Teams"
Add-SPOSiteDesign -Title "City Team Site" -WebTemplate "64" -SiteScripts $id -Description "Themed for City Teams" -IsDefault