function Out-ColoredNames
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true, 
           ValueFromPipeline=$true, 
           ValueFromPipelineByPropertyName = $true )]
[string[]]$Name,

[Parameter(ValueFromPipelineByPropertyName)]
[long]$PagedMemorySize64 = 0
)
Begin
{
    $colorint = Get-Random -Minimum 0 -Maximum 15
}
Process
{
foreach($Entry in $Name)
{
    $Ausgabe = $Entry 
    if($PagedMemorySize64 -gt 0)
    {
        $Ausgabe += " PM: $PagedMemorySize64"
    }
    Write-Host -Object $Ausgabe -ForegroundColor $Colorint
}
}
End
{
    Write-Host -Object "Ende der Ausgabe"
}

}

function New-CompanyEmailAdress
{
<#
.SYNOPSIS
 Genertor für Email Adressen
.DESCRIPTION
 Diese Funktion kann entweder auf Basis von CSV oder manueller Eingabe eine EMail Adresse erzeugen
#>
[cmdletbinding(DefaultParameterSetName="Default")]
param(
[Parameter(Mandatory=$true,
           ParameterSetName="CSV")]
[string]$CSVPath,

[Parameter(Mandatory=$true,
           ValueFromPipelineByPropertyName=$true,
           ParameterSetName="Default")]
[string]$GivenName,

[Parameter(Mandatory=$true,
           ValueFromPipelineByPropertyName=$true,
           ParameterSetName="Default")]
[string]$Surname,

[Parameter(ParameterSetName="CSV")]
[Parameter(ParameterSetName="Default", Mandatory=$true)]
[string]$CompanyDomain = "ppedv.test"

)
    Write-Verbose -Message $PSCmdlet.ParameterSetName
    switch($PSCmdlet.ParameterSetName)
    {
        "CSV" {
                $rawuser = Import-Csv -Path $CSVPath
                foreach($user in $rawuser)
                {
                    [string[]]$Name += (Convert-String -InputObject "$($user.GivenName) $($user.Surname)" -Example "Vorname Nachname=VornameN") + "@" + $CompanyDomain
                }
                }
        "Default" {
                [string]$Name = (Convert-String -InputObject "$Givenname $Surname" -Example "Vorname Nachname=VornameN") + "@" + $CompanyDomain
                }
    }
    return $Name
}
