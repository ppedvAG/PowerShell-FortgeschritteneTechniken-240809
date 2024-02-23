Configuration dynamicServerConfig
{
    Node $AllNodes.Nodename
    {
        LocalConfigurationManager
        {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 20
        }
        foreach($Feature in $Node.WindowsFeatures)
        {
            WindowsFEature $Feature.Name
            {
                Name = $Feature.Name
                Ensure = $Feature.Ensure
            }
        }
    }
}

dynamicServerConfig -OutputPath "C:\24KW08\DSC" -ConfigurationData "C:\24KW08\DSC\dsc-produkt1.psd1"

Start-DscConfiguration -Wait -Verbose -Path C:\24KW08\DSC
Set-DscLocalConfigurationManager -Path C:\24KW08\DSC