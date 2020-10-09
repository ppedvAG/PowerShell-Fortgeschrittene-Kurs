
function Set-Colors
{
$ShellSitzung =  $Host.UI.RawUI

$ShellSitzung.WindowTitle= "StefanO Shell"
$ShellSitzung.BackgroundColor = "White"
$ShellSitzung.ForegroundColor = "Black"
if((Get-Command Set-PSReadLineOption).Version.Major -lt 2)
{
Write-Verbose "PSReadlineV1"
Set-PSReadlineOption -TokenKind Command   -ForegroundColor DarkBlue
Set-PSReadlineOption -TokenKind Parameter -ForegroundColor Blue
Set-PSReadlineOption -TokenKind Number    -ForegroundColor DarkRed
Set-PSReadlineOption -TokenKind Member    -ForegroundColor Gray
}
else
{
Write-Verbose "PSReadlineV2"
Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Blue
                               "Command"   = [Consolecolor]::DarkBlue
                               "Number"    = [Consolecolor]::DarkRed
                               "Member"    = [ConsoleColor]::Gray
                               "String"    = [Consolecolor]::DarkGreen
                               "Comment"   = [ConsoleColor]::Green
                               "Keyword"   = [ConsoleColor]::Magenta
                               "None"      = [ConsoleColor]::Black
                               "Operator"  = [ConsoleColor]::DarkMagenta
                               "Type"      = [ConsoleColor]::Cyan
                               "Variable"  = [ConsoleColor]::DarkCyan}
}
cls
}

Set-Colors

function Prompt
{
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
    if($principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator ))
    {
        $shellstatus = "elevated"
    }
    else
    {
        $shellstatus = "User"
    }

    Write-Host "[$env:COMPUTERNAME][$Shellstatus]"(Get-Location)">" -ForegroundColor (Get-Random -Minimum 1 -Maximum 16)
}