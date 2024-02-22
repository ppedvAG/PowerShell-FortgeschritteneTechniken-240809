<#
.Synopsis
   Abfrage von Logon Events
.DESCRIPTION
   Mithilfe dieses Skriptes können Events betreffend der user Session abgefragt werden. Wie zb Anmeldung, Abmeldung sowie fehlgeschlagene Anmeldungen
.PARAMETER EventId
   Mit diesem Parameter kann angegeben werden welche Events abgefragt werden . Folgende Werte sind möglich:
   4624 Anmeldung
   4625 fehlgeschlagene Anmeldung
   4634 Abmeldung
.EXAMPLE
   Get-SecEvents.ps1 -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  678494 Feb 22 11:54  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  678491 Feb 22 11:54  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  678488 Feb 22 11:53  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  678483 Feb 22 11:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  678480 Feb 22 11:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

  Hier wird standardmäßig die fünf aktuellestne Anmeldungen angezeigt
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding()]
param(
[string]$Computername = "localhost",

[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5
)

Write-Verbose -Message "Zusätzliche Ausgabe"
Write-Verbose -Message "Der User hat folgende Werte angegeben EventId: $EventId"

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

