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

