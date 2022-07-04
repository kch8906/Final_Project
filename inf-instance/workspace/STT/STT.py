import os
import requests
import json
import tensorflow as tf
import numpy as np
import paho.mqtt.publish as publisher
import librosa
import sklearn

files_Path = "/mnt/audio/"
file_name_and_time_lst = []

for f_name in os.listdir(f"{files_Path}"):
    written_time = os.path.getctime(f"{files_Path}{f_name}")
    file_name_and_time_lst.append((f_name, written_time))

sorted_file_lst = sorted(file_name_and_time_lst, key=lambda x: x[1], reverse=True)
recent_file = sorted_file_lst[0]
recent_file_name = recent_file[0]
recent_file_name = files_Path + recent_file_name

pad2d = lambda a, i: a[:, 0:i] if a.shape[1] > i else np.hstack((a, np.zeros((a.shape[0], i-a.shape[1]))))

wav, sr = librosa.load(recent_file_name, sr=None)
mfcc = librosa.feature.mfcc(wav, sr=16000, n_mfcc=100, n_fft=400, hop_length=160)
mfcc = sklearn.preprocessing.scale(mfcc, axis=1)
padded_mfcc = pad2d(mfcc, 400)
padded_mfcc= np.expand_dims(padded_mfcc, 0)

model_test = tf.keras.models.load_model('/home/ubuntu/workspace/STT/stt_cnn_0623.h5')
result = model_test.predict(padded_mfcc)
food = np.argmax(result[0])

publisher.single("audio", f"{food}", hostname= "18.142.203.134")
