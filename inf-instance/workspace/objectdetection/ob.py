import os
import requests
import json

files_Path = "/mnt/images/train/"
file_name_and_time_lst = []

for f_name in os.listdir(f"{files_Path}"):
    written_time = os.path.getctime(f"{files_Path}{f_name}")
    file_name_and_time_lst.append((f_name, written_time))

sorted_file_lst = sorted(file_name_and_time_lst, key=lambda x: x[1], reverse=True)
recent_file = sorted_file_lst[0]
recent_file_name = recent_file[0]



%cd /home/ubuntu/workspace/yolov5

!python3 detect.py --weights /home/ubuntu/workspace/model_weights/yolov5m_best.pt \
                            /home/ubuntu/workspace/model_weights/yolov5l_best.pt \
                  --conf 0.65 --source /mnt/images/train/recent_file_name
                  --project /home/ubuntu/workspace/inference_result --save-txt
