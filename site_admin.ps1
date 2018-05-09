$ownersGroup = Get-PnPGroup -AssociatedOwnerGroup

Add-PnPUserToGroup -Identity $ownersGroup -EmailAddress adminjoe.crockett@qa01alexandriava.net 
Remove-PnPUserFromGroup -LoginName adminjoe.crockett@qa01alexandriava.net -Identity $ownersGroup