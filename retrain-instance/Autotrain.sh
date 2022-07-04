#!/bin/bash

sleep 120

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ubuntu/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ubuntu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ubuntu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ubuntu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate env_pj

sleep 5

cd /home/ubuntu/workspace/yolov5

python3 train.py --img 416 --batch 32 --epochs 500 --data /home/ubuntu/workspace/dataset/data.yaml \
                                                   --cfg /home/ubuntu/workspace/hyp/config.yaml \
                                                   --project=/mnt/weights \
                                                   --weights /home/ubuntu/workspace/weight/best.pt \
                                                   --name age2500_yolov5x_batch32_img416


export AWS_ACCESS_KEY_ID='AAKIAV25E3FRV6Z4CMUPY'
export AWS_SECRET_ACCESS_KEY='J62qvTmxSN4XlhbwxyMc8APBunt0tLxbbpSBfLNB'
AWSCLI=$(which aws)
AWS_INSTANCES=(
                ap-northeast-1:i-1234567890abcdef0
              )


instance_stop() {
  until [[ $INSTANCE_CHECK == "stopped" ]]
    do
    INSTANCE_CHECK=$($AWSCLI ec2 describe-instances --region $REGION --instance-ids $INSTANCE --output text \
                             --query "Reservations[*].Instances[*].[State.Name]")
    if [[ $INSTANCE_CHECK == "running"  ]];then
      $AWSCLI ec2 stop-instances --region $REGION --instance-ids $INSTANCE
      sleep 5
    elif [[ $INSTANCE_CHECK == "stopping"  ]];then
      sleep 10
    elif [[ -z $INSTANCE_CHECK ]];then
      break 1;
    fi
    ((COUNT_LOOP++))
    if [ $COUNT_LOOP -ge 360 ];then
      break 1;
    fi
    done
  unset INSTANCE_CHECK COUNT_LOOP
}
 
for a in ${AWS_INSTANCES[*]}
  do
  REGION=$(echo $a|cut -d":" -f1)
  INSTANCE=$(echo $a|cut -d":" -f2)
  instance_stop;
  unset REGION INSTANCE
  done
 
unset AWS_INSTANCES AWSCLI AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
exit 0



