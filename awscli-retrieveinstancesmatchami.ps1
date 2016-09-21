﻿#title           :awscli-retrieveinstancesmatchami.ps1

$list = aws ec2 describe-images --query 'Images[*].[ImageId]' --output text --filters "Name=description,Values=*Windows*" 
$filterCount = [int][Math]::Ceiling($list.count/200)
$filters = @("") * $filterCount
$a = 0
$c = 0
for($i=0; $i -le $list.count; $i++){ 
    if ($c -eq 0){
        $tempList = $list[$i]
    }
    else{
        $tempList = $tempList + "," + $list[$i]
    }
    if(($c -eq 199) -or (($a -eq $filterCount-1) -and ($i -eq $list.count))){
        $filters[$a] = $tempList
        $tempList = $_
        $a++
        $c=-1
     }
    $c+=1
}
$filters | foreach{
    aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text --filters "Name=image-id,Values=$_)"
}