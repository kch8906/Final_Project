# 디지털 소외계층을 위한 키오스크 프로젝트

딥러닝(Object Detection)으로 노년층, 일반층과 남성, 여성을 판단하여 노년층일 경우 UI가 변하고 STT로 주문을 유도하는 서비스이다. 또한 측정된 Label이 노년층 여성이면 노년층 여성이 많이 주문한 메뉴를 추천하는 키오스크
AWS로 진행하여 EC2 내부에 있는 코드만 업로드

# Skill
### AI Agorithms
Object Detection - Yolov5
Speech to Text - CNN (단어의 스펙트럼을 이미지로 변환(librosa) 후 추론)

### AWS
EC2, Lambda, System Manager, EventBridge, S3

### Others
Goofys(s3 - ec2 폴더 마운트)
Shell Script

# Blog
https://crysis.tistory.com/4?category=984169 

# Pipeline

### 1. 추론 파이프라인
![img1 daumcdn](https://user-images.githubusercontent.com/64409693/190300915-95fad20a-9b5c-45ca-9a8b-f18296dae68d.png)

### 2. 자동학습 파이프라인
![img1 daumcdn1](https://user-images.githubusercontent.com/64409693/190300934-29dcfc74-c510-4f56-a370-d20ec9cc86a8.png)


