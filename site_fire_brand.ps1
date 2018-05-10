$creds = Get-Credential
$LoginName = "joseph.crockett.a@alexandriava.gov"
$adminUrl = "https://alexandriava1-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl -Credential $creds



function Set-CoaPnpTheme ([psobject]$SubWebConnection)
{
    Add-PnPFile -Connection $SubWebConnection -Path .\afd-logo.png -Folder "SiteAssets"
    $siteRelUrl = (Get-PnPWeb -Connection $SubWebConnection).ServerRelativeUrl
    $siteLogoUrl = $siteRelUrl + "/SiteAssets/afd-logo.png"
    Set-PnPTheme -Connection $SubWebConnection
    Set-PnPWeb -SiteLogoUrl $siteLogoUrl
    Clear-Variable siteRelUrl
}



    $Url = "https://alexandriava1.sharepoint.com/sites/fire"
    $Url
    $UserTrue = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $true
    Start-Sleep -Seconds 1
    $Connection = Connect-PnPOnline -Url $Url -Credentials $creds -ReturnConnection
    Set-CoaPnpTheme($Connection)
    Get-PnPSubWebs -Recurse -Connection $Connection | ForEach-Object {
        $CurrentSubWeb = $BaseUrl + $_.ServerRelativeUrl
        $CurrentSubWeb
        $SubWebConnection = Connect-PnPOnline -Url $CurrentSubWeb -Credentials $creds -ReturnConnection
        Set-CoaPnpTheme ($SubWebConnection)
    }

    $userFalse = Set-SPOUser -Site $Url -LoginName $LoginName -IsSiteCollectionAdmin $false

