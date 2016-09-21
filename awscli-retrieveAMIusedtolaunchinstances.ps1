#title           :awscli-retrieveAMIusedtolaunchinstances.ps1#description     :Retrieves instances matchin keywords in AMI used to launch it#author          :booysenn#date            :20160921#version         :0.1#usage           :Copy code modify and run#notes           :Requires AWS CLI#==============================================================================
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
