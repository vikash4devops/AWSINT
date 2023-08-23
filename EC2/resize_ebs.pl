
Note:- EBS Volume can never be decreased, it can only be increased.

1)  There is option of Root/Block Devices (click to hover) under server details information in aws ec2 instance console.

2)  click to EBS ID option (when it on hover), it will redirect to ebs volume section, select ebs and click to "Modify" option,
    now enter the EBS size (15GB eg) and save it.
    
3)  it will be updated in aws console, but when you login in CLI it does not reflect the changes, so need to hit below commands to change the updations
    
    commands:-
    
    lsblk:- to list the volumes, here it will show 15GB new updated volume size.
            but df-h will still shows old size of 8GB.
            
    hit below command to update in real mounted volume size.
    
            i)  sudo growpart /dev/xvda 1   (update the changes to given volume disk)
            ii) sudo resize2fs /dev/xvda1   (resize the given disk volume size)
          
