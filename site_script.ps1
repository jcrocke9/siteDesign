$site_script = @'
{
 "$schema": "schema.json",
     "actions": [
         {
             "verb": "applyTheme",
             "themeName": "Alex2"
         },
         {
            "verb": "addNavLink",
            "url": "https://qa01alexandriava.sharepoint.com/SitePages/Home.aspx",
            "displayName": "",
            "isWebRelative": false
         }
     ],
         "bindata": { },
 "version": 1
}
'@

$id = Add-SPOSiteScript -Title "City Team Site" -Content $site_script -Description "Themed for City Teams"
# Add-SPOSiteDesign -Title "City Team Site" -WebTemplate "64" -SiteScripts $id -Description "Themed for City Teams"


Set-SPOSiteDesign -Identity 50b2db43-b240-43d4-a05e-f0ec916801c2 -WebTemplate "64" -SiteScripts $id -Description "Themed for City Teams" -IsDefault:$true