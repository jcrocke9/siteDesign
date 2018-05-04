Get-SPOSite -Limit ALL | Where-Object {$_.Template -eq "GROUP#0"} | ForEach-Object {
    Connect-PnPOnline -Url $_
    $Look = (Get-PnPTheme -DetectCurrentComposedLook).Name
    $CompDetails = New-Object psobject -Property @{
        Url          = $_
        ComposedLook = $Look
    }
    $CompDetails
}
