﻿
#title           :awsPowershellTools-retrieveAMIusedtolaunchinstances.ps1
#==============================================================================
Get-EC2Instance -region eu-west-1 | foreach {
    $instanceConsoleB64 = Get-EC2ConsoleOutput -InstanceId $_.Instances.InstanceID -region eu-west-1
    $instanceConsole = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($instanceConsoleB64.output))
    $instanceConsoleArr = ($instanceConsole -split '[\r\n]') |? {$_} 
    foreach ($line in $instanceConsoleArr) {
        if ($line -match "AMI Origin Name" -and $line -match "Windows" -and $line -match "Server" -and $line -match "SQL") {
            echo $_.Instances.InstanceID
            break
        }
    }
}