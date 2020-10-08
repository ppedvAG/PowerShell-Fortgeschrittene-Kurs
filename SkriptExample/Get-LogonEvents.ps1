[cmdletBinding()] #Benutze Powershell default Parameter
Param(
[Parameter(ParameterSetName="Manuell")]
[string]$Logname = "Security",
[Parameter(ParameterSetName="Manuell")]
[string]$Computername = "localhost",
[Parameter(Mandatory=$true,ParameterSetName="Manuell")]
[Parameter(Mandatory=$false,ParameterSetName="CSV")] #Parametereigenschaften wie zb Pflicht Parameter
[int]$EventId,
[Parameter(ParameterSetName="Manuell")]
[int]$Newest = 5,
[Parameter(Mandatory=$True,ParameterSetName="CSV")]
[string]$Configpath
)

#Verbose also zusätzliche Ausgabe die bei angabe von -Verbose mit ausgegeben wird
Write-Verbose -Message "Das Skript wurde mit folgenden Werten gestartet. Logname: $Logname, EventID: $EventId"
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object -FilterScript {$_.EventID -eq $EventId} | Select-Object -First $Newest