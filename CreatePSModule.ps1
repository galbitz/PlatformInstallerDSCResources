#Setup
if (-Not(Find-PackageProvider -Name NuGet)){
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}


if (-Not (Get-Module -ListAvailable -Name xDscResourceDesigner)) {
    Install-Module xDscResourceDesigner -Force
}

#Create module

New-xDscResource -Name cRegDll -Property (
    New-xDscResourceProperty -Name FilePath -Type String -Attribute Key), (
    New-xDscResourceProperty –Name Ensure –Type String –Attribute Write –ValidateSet 'Absent', 'Present'
) -Path ".\Modules\PlatformInstaller\" -Verbose


New-ModuleManifest -Path ".\Modules\PlatformInstaller\PlatformInstaller.psd1"
