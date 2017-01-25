
Copy-Item .\Modules\PlatformInstaller "$PSHOME\Modules" -Force -Recurse
$dllpath = "c:\dev\dotnet\legacy\03-System\Library\DBLayer.DLL"

Invoke-DscResource -Name cRegDll -modulename platforminstaller -Method Set -Property @{ FilePath=$dllpath; Ensure="Present"} -Verbose
Invoke-DscResource -Name cRegDll -modulename platforminstaller -Method Test -Property @{ FilePath=$dllpath} -Verbose

