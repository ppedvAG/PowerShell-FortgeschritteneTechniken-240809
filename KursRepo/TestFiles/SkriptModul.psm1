function New-TestFilesDir
{
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

New-Testfiles -Path $TestDir.FullName -FileAmount $FileAmount

for($i = 1; $i -le $DirAmount; $i++)
{
    $Dirnumber = "{0:D2}" -f $i

    $DirName = "Ordner" + $Dirnumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    New-Testfiles -Path $subdir.FullName -FileAmount $FileAmount -Name ("File_" + $Dirnumber + "_")
}

}

function New-Testfiles
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -PathType Container})]
    [string]$Path,

    [ValidateRange(1,99)]
    [int]$FileAmount = 9,

    [Validatelength(5,20)]
    [string]$Name = "File"
)

    for($i = 1; $i -le $FileAmount; $i++)
    {
        $Filenumber = "{0:D2}" -f $i
        $Filename = $Name + $Filenumber + ".txt"
        New-Item -Path $Path -Name $Filename -ItemType File
    }
}
