[cmdletBinding()]
Param(
$Logname,
$Computername,
$EventId,
$Newest
)
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object -FilterScript {$_.EventID -eq $EventId} | Select-Object -First $Newest