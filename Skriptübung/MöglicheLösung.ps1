[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -PathType Container})]
    [string]$Path,

    [ValidateRange(1,99)]
    [int]$FileAmount = 9,

    [ValidateRange(0,99)]
    [int]$DirAmount = 3,

    [Validatelength(5,20)]
    [string]$DirName = "TestFiles2",

    [switch]$Force
)

if($Path.EndsWith("\"))
{
    $TestDirPath = $Path + $DirName + "\"
}
else
{
    $TestDirPath = $Path + "\" + $DirName + "\"
}

if(Test-Path -Path $TestDirPath)
{
    if($Force)
    {
        Remove-Item -Path $TestDirPath -Recurse -Force
    }
    else
    {
        Write-Host -Object "Ordner bereits vorhanden" -ForegroundColor Red
        exit
    }
}

$TestDir = New-Item -ItemType Directory -Path $TestDirPath 

for($i = 1; $i -le $FileAmount; $i++)
{
    $Filenumber = "{0:D2}" -f $i

    $Filename = "File" + $Filenumber + ".txt"

    New-Item -Path $TestDir.FullName -Name $Filename -ItemType File

}

for($i = 1; $i -le $DirAmount; $i++)
{
    $Dirnumber = "{0:D2}" -f $i

    $DirName = "Ordner" + $Dirnumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileAmount; $j++)
    {
        $Filenumber = "{0:D2}" -f $j

        $Filename = "File_o" + $Dirnumber + "_" + $Filenumber + ".txt"

        New-Item -Path $subdir.Fullname -Name $Filename -ItemType File

    }

}