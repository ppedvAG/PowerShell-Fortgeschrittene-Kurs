[cmdletBinding()] #Benutze Powershell default Parameter
Param(
[string]$Logname = "Security",
[string]$Computername = "localhost",
[Parameter(Mandatory=$true)] #Parametereigenschaften wie zb Pflicht Parameter
[int]$EventId,
[int]$Newest = 5
)

#Verbose also zusätzliche Ausgabe die bei angabe von -Verbose mit ausgegeben wird
Write-Verbose -Message "Das Skript wurde mit folgenden Werten gestartet. Logname: $Logname, EventID: $EventId"
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object -FilterScript {$_.EventID -eq $EventId} | Select-Object -First $Newest