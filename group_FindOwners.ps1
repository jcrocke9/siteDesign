$groupInfo = @()
Get-AzureADMSGroup -All:$true | where-object {$_.GroupTypes -like "*Unified*"} | foreach-object {
    $id = $_.Id
    $name = $_.DisplayName

    $owner = @()
    $owner = (Get-AzureADGroupOwner -ObjectId $id).UserPrincipalName
    $owner | ForEach-Object {
        $group = New-Object psobject -Property @{
            Id = $id
            DisplayName = $name
            Owner = $_
        }
        $groupInfo += $group
    }
}
$groupInfo | Export-Csv -Path C:\alex\out\GroupInfo.csv
