#region: Logging Start
$logLineTime = (Get-Date).ToString()
$logFileDate = Get-Date -UFormat "%Y%m%d"
$logLineInfo = "`t$([Environment]::UserName)`t$([Environment]::MachineName)`t"
$logCode = "Start"
$writeTo = "Starting Misc Command Script"
$logLine = $null
function WriteToLog {
    param([string]$logLineTime,[string]$writeTo,[string]$logCode)
    $logLine = $logLineTime
    $logLine += $logLineInfo
    $logLine += $logCode; $logLine += "`t"
    $logLine += $writeTo
    $logLine | Out-File -FilePath "C:\alex\out\siteDesign_$logFileDate.log" -Append -NoClobber
    Clear-Variable logLine -Scope global
    Clear-Variable writeTo -Scope global
    Clear-Variable logLineTime -Scope global
    Clear-Variable logCode -Scope global
    }
WriteToLog -logLineTime $logLineTime -writeTo $writeTo -logCode $logCode
#endregion



$writeTo = "Ran the WriteToLog Script"
$logCode = "Success"
$logLineTime = (Get-Date).ToString()
WriteToLog -logLineTime $logLineTime -writeTo $writeTo -logCode $logCode
