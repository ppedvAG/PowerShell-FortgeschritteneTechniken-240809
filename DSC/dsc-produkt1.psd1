@{
    AllNodes = @(
        @{
            NodeName = "Member1"
            WindowsFeatures = @(
                @{
                    Name="Web-Server"
                    Ensure = "Present"
                },
                @{
                    Name="Web-mgmt-tools"
                    Ensure = "Present"
                }                            
            )
        },
        @{
            NodeName = "Member2"
            WindowsFeatures = @(
                @{
                    Name="FS-FileServer"
                    Ensure = "Present"
                },
                @{
                    Name="FS-Data-Deduplication"
                    Ensure = "Present"
                }                            
            )
        }
    )
}