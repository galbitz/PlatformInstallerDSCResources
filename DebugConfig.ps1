[DSCLocalConfigurationManager()]
Configuration LCMDebugMode {
    Node localhost {
        Settings {
            ConfigurationMode    = 'ApplyOnly'
            RefreshMode          = 'Disabled'
            Debugmode            = 'ForceModuleImport'
        }
    }
}

LCMDebugMode -OutputPath config
Set-DscLocalConfigurationManager -Path config -Verbose
Get-DscLocalConfigurationManager

Restart-Service -Name winmgmt -Force -Verbose