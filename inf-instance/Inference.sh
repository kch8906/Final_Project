#!/bin/bash

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

conda activate env_inf

path1='/mnt/images/train/'
cd $path1
FILE=`ls | tail -1`
#FILE=`ls -ltr | tail -1`
#FILENAME=${FILE:(-10)}
echo ${FILE}

cd /home/ubuntu/workspace/yolov5
python3 detect.py --weights /home/ubuntu/workspace/model_weights/yolov5m_best.pt \
			                /home/ubuntu/workspace/model_weights/yolov5l_best.pt \
                  --conf 0.65 --source /mnt/images/train/${FILE} \
		          --project /home/ubuntu/workspace/inference_result --save-txt


for loopdirectory in `ls -d /home/ubuntu/workspace/inference_result/*`;
do
        echo $loopdirectory;
        for datadirectory in `ls $loopdirectory/*`;
        do
                filename=$datadirectory;
        done
done

echo ${filename}

value=`cat /home/ubuntu/workspace/inference_result/exp/labels/${filename}`
label=${value:0:1}
echo ${label}
mosquitto_pub -h 18.142.203.134 -p 1883 -t test -m "${label}"

sleep 2

sudo find /home/ubuntu/workspace/inference_result -name '*.txt' -exec cp {} /mnt/labels/train \;
sudo rm -rf /home/ubuntu/workspace/inference_result/exp





