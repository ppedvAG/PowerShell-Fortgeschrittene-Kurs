<#
    .SYNOPSIS 
    Kurzbeschreibung: Abfrage von Events aus dem ETW
    .DESCRIPTION
    Langebschreibung: blalblabllbalbablb
    .PARAMETER Logname
    Mit diesem Parameter kann der Logname angegeben werden. Standardmäßig ist hier Security hinterlegt
    .EXAMPLE 
    .\Get-LogonEvents.ps1 -EventId 4634

    Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   10985 Okt 08 14:23  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10981 Okt 08 14:22  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10978 Okt 08 14:21  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10977 Okt 08 14:21  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10974 Okt 08 14:21  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....

    Frägt das Securitiy Eventlog ab um die aktuellesten 5 Abmeldungen anzuzueigen

#>
[cmdletBinding()] #Benutze Powershell default Parameter
Param(
[Parameter(ParameterSetName="Manuell",ValueFromPipeLineByPropertyName=$true)]
[ValidateSet("Security","System")]
[string]$Logname = "Security",

[Parameter(ParameterSetName="Manuell",ValueFromPipeLineByPropertyName=$true)]
[Validatescript({Test-NetConnection -ComputerName $_ -CommonTCPPort WinRM -InformationLevel Quiet})]
[string]$Computername = "localhost",

[Parameter(Mandatory=$true,ParameterSetName="Manuell",ValueFromPipeLineByPropertyName=$true)]
[Parameter(Mandatory=$false,ParameterSetName="CSV")] #Parametereigenschaften wie zb Pflicht Parameter
[int]$EventId,

[Parameter(ParameterSetName="Manuell",ValueFromPipeLineByPropertyName=$true)]
[ValidateRange(5,20)]
[int]$Newest = 5,

[Parameter(Mandatory=$True,ParameterSetName="CSV")]
[ValidateScript({(Test-Path -Path $_) -and ($_.EndsWith(".csv"))})]
[string]$Configpath,

[ValidatePattern("[E][X][-][0-9][0-9][a-F]")]
$validatepatterntest
)
#Hilfe Link zu Advanced Parameter: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1
#Verbose also zusätzliche Ausgabe die bei angabe von -Verbose mit ausgegeben wird
Write-Verbose -Message "Das Skript wurde mit folgenden Werten gestartet. Logname: $Logname, EventID: $EventId"

#Debugmöglichkeit inform von Write-Debug
Write-Debug -Message "Vor Event Abfrage"

Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object -FilterScript {$_.EventID -eq $EventId} | Select-Object -First $Newest