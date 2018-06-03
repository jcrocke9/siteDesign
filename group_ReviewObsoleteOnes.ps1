$newOwner = "joseph.crockett@alexandriava.gov"
$name = "ITIL Service Desk Implementation"
Get-UnifiedGroupLinks -LinkType Members -Identity $name
Add-UnifiedGroupLinks -LinkType Member -Identity $name -Links $newOwner
Add-UnifiedGroupLinks -LinkType Owner -Identity $name -Links $newOwner

$toRemove = "joseph.crockett@alexandriava.gov"
$name = "Department Heads Collaboration"
Get-UnifiedGroupLinks -LinkType Owner -Identity $name
Pause
Remove-UnifiedGroupLinks -LinkType Owner -Identity $name -Links $toRemove
Get-UnifiedGroupLinks -LinkType Members -Identity $name
Pause
Remove-UnifiedGroupLinks -LinkType Member -Identity $name -Links $toRemove
