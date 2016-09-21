﻿#title           :awscli-retrieveAMIusedtolaunchinstances.ps1
aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | foreach {
    $instanceConsole = aws ec2 get-console-output --instance-id $_
    $instanceConsoleArr = $instanceConsole.replace("\r\n","`r").split("`r")
    foreach ($line in $instanceConsoleArr) {
        if ($line -match "AMI Origin Name" -and $line -match "Windows" -and $line -match "Server" -and $line -match "SQL") {
            echo $_
            break
        }
    }
}