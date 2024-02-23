class Vehicle
{
    [string]$Farbe
    [string]$Hersteller
    [int]$Sitzplätze
    [int]$Höchstgewschwindigkeit
}

class Auto : Vehicle
{
    [int]$Räder
    [string]$Model
    [Antrieb]$Motor
    [int]$PS

    #Konstruktor, wird ausgeführt beim erstellen einer neuen Instanz der Klasse
    Auto()
    {
        #Default Konstruktor wenn keine Werte übergeben werden
    }
    Auto([string]$Hersteller)
    {
        $this.Hersteller = $Hersteller
    }

    #Methoden
    [void]Fahre([int]$Strecke)
    {
        [int]$Speed = 0
        [string]$Fahrbahn = "🚗"
        for($i = 1; $i -le $Strecke; $i++)
        {
            $Fahrbahn = "-" + $Fahrbahn 
            if($Speed -le $this.Höchstgewschwindigkeit)
            {
                $Speed += 15
            }
            
            Start-Sleep -Milliseconds (300 - $Speed)
            Clear-Host
            Write-Host -Object $Fahrbahn
        }
    }


    #Überladene Methoden
    [string]ToString()
    {
        [string]$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Model + " ]"
        return $Ausgabe
    }
    [string]ToString([string]$Informationlevel)
    {
        [string]$Ausgabe = ""
        switch($Informationlevel)
        {
            Detailed {$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Model + " Leistung: " + $this.PS + " PS " + "( $($this.Motor))" +  "]"}
            Default {$Ausgabe = $this.ToString()}
        }
        return $Ausgabe
    }
}

enum Antrieb
{
    Sonstiges
    Benzin
    Diesel
    Elektrisch
    Hybrid
    Wasserstoff
}


#$MyCar = [Auto]::new()
$MyCar = [Auto]::new("BMW")
$MyCar.Farbe = "Grau Metallic"
#$MyCar.Hersteller = "BMW"
$MyCar.Model = "F31"
$MyCar.Motor = [Antrieb]::Benzin
$MyCar.Höchstgewschwindigkeit = 260
$MyCar.PS = 252
$MyCar.Räder = 4
$MyCar.Sitzplätze = 5

$MyCar.Fahre(150)
