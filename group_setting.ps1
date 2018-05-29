# NEW
# $Template = Get-AzureADDirectorySettingTemplate -Id 62375ab9-6b52-47ed-826b-58e47e0e304b
# $Setting = $template.CreateDirectorySetting()

# Update
$Id = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).Id
$setting = Get-AzureADDirectorySetting -Id $Id

$setting["ClassificationList"] = "Administrative, Public Use Data, Protected Data - Restricted, Protected Data - Highly Sensitive"
$setting["ClassificationDescriptions"] = "Administrative: Data of a routine administrative nature, Public Use Data: Data intended for general public use, Protected Data - Restricted: Data related to employee performance or evaluations or other confidential information, Protected Data - Highly Sensitive: Data related to financial or identity theft"
# HIPAA: Data related to the Health Insurance Portability and Accountability Act, CJI: Data related to Criminal Justice Information
$setting["PrefixSuffixNamingRequirement"] = "[Department]_[GroupName]"
$setting["UsageGuidelinesUrl"] = ""

# New-AzureADDirectorySetting -DirectorySetting $setting
Set-AzureADDirectorySetting -Id $Id -DirectorySetting $setting
