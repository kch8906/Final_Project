#!/bin/bash

sudo goofys -o allow_other sagemaker-changhyun:input /mnt/images/train
sudo goofys -o allow_other sagemaker-changhyun:labels /mnt/labels/train
sudo goofys -o allow_other yolov5-model-weights /mnt/weights


