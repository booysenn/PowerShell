
#title           :awsPowershellTools-retrieveAMIusedtolaunchinstances.ps1#description     :Retrieves instances matchin keywords in AMI used to launch it#author          :booysenn#date            :20160921#version         :0.1#usage           :Copy code modify and run#notes           :Requires AWS PowerShell Tools
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