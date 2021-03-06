function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $FilePath
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    FilePath = [System.String]
    Ensure = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $FilePath,

        [ValidateSet("Absent","Present")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1

    $registerOption =""
    switch ($Ensure)
    {
        'Present'
        {

        }
        'Absent'
        {
            $registerOption = "/u"
        }
    }
    try {
        Start-Process -FilePath 'regsvr32.exe' -Args "$registerOption /s $FilePath" -Wait -NoNewWindow -PassThru
    }
    catch {
        Write-Error $_.Exception.Message
        return $false
    }
    return $true
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $FilePath,

        [ValidateSet("Absent","Present")]
        [System.String]
        $Ensure
    )

    try {
        $process = Start-Process -FilePath 'reg.exe' -Args "query HKLM\SOFTWARE\Classes /s /f $FilePath" -Wait -NoNewWindow -PassThru
        #If exitcode = 1 missing dll 
        if ($process.ExitCode -eq 1)
        {
            return $false
        }
        else {
            return $true
        }
    }
    catch {
        Write-Verbose $_.Exception.Message
        return $false
    }
}


Export-ModuleMember -Function *-TargetResource

