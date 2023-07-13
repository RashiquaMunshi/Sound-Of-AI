import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from flask import Flask, request, send_file
import librosa
import numpy as np
import librosa
import pandas as pd
import soundfile as sf
import librosa.display
from PIL import Image
import os
import tensorflow as tf
import scipy.signal as signal
import tempfile

app = Flask(__name__)

model = tf.keras.models.load_model(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\sound_model_heartresnet.hdf5")
model1 = tf.keras.models.load_model(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\audio_model")

d = {0: 'Artifact', 1: 'Extrahs', 2: 'Murmur', 3: 'Normal'}
d1 = {0: 'air_conditioner', 1: 'car_horn', 2: 'children_playing', 3: 'dog_bark', 4: 'drilling', 5: 'engine_idling', 6: 'gun_shot', 7: 'jackhammer', 8: 'siren', 9: 'street_music'}

def func(filename):
    audio, sample_rate = librosa.load(filename)
    
    plt.figure(figsize=(10,3))
    librosa.display.waveshow(audio,sr=sample_rate)
    plt.savefig(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\imgplot.png")
    plt.close()

    spectrogram = librosa.feature.melspectrogram(y=audio, sr=sample_rate)
    spectrogram_db = librosa.power_to_db(spectrogram, ref=np.max)

    plt.figure(figsize=(8,3))
    librosa.display.specshow(spectrogram_db)
    plt.colorbar(format='%+2.0f dB')
    plt.savefig(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\specshow.png")
    plt.close()

    mfccs_features = librosa.feature.mfcc(y=audio, sr=sample_rate, n_mfcc=40)
    mfccs_scaled_features = np.mean(mfccs_features.T,axis=0)
    mfccs_scaled_features=mfccs_scaled_features.reshape(-1,1,40)
    predicted_label=np.argmax(model1.predict(mfccs_scaled_features),axis=1)
    return d1[predicted_label[0]]

def apply_low_pass_filter(audio, sampling_rate, cutoff_freq):
    nyquist_freq = 0.5 * sampling_rate
    normalized_cutoff_freq = cutoff_freq / nyquist_freq
    b, a = signal.butter(4, normalized_cutoff_freq, btype='low', analog=False)
    denoised_audio = signal.lfilter(b, a, audio)
    return denoised_audio

def downsample_audio(audio, original_sampling_rate, target_sampling_rate):
    resampled_audio = librosa.resample(audio, orig_sr=original_sampling_rate, target_sr=target_sampling_rate)
    return resampled_audio

def split_audio(audio, segment_length):
    num_segments = len(audio) // segment_length
    segments = [audio[i*segment_length:(i+1)*segment_length] for i in range(num_segments)]
    return segments

x=""

@app.route('/predict',methods=['POST'])
def predict():
    if 'audio' not in request.files:
        return 'No file provided', 400

    audio_file = request.files['audio']
    if not audio_file.filename.lower().endswith('.wav'):
        return 'Invalid file type, must be .wav', 400
    prediction = func(audio_file)
    print(prediction)
    return prediction

@app.route('/process_audio', methods=['POST'])
def process_audio():
    if 'audio_file' not in request.files:
        return 'No audio found.', 400

    audio = request.files['audio_file']
    if not audio.filename.lower().endswith('.wav'):
        return 'Invalid file type, must be .wav', 400
    x=audio
    heart_class = []
    heart_confidence = []

    data, sampling_rate = librosa.load(audio, sr=None)

    plt.figure(figsize=(10,3))
    librosa.display.waveshow(data,sr=sampling_rate)
    plt.savefig(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\imgplot.png")
    plt.close()

    spectrogram = librosa.feature.melspectrogram(y=data, sr=sampling_rate)
    spectrogram_db = librosa.power_to_db(spectrogram, ref=np.max)

    plt.figure(figsize=(8,3))
    librosa.display.specshow(spectrogram_db)
    plt.colorbar(format='%+2.0f dB')
    plt.savefig(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\specshow.png")
    plt.close()

    cutoff_frequency = 195
    denoised_audio = apply_low_pass_filter(data, sampling_rate, cutoff_frequency)

    target_sampling_rate = sampling_rate // 10
    downsampled_audio = downsample_audio(denoised_audio, sampling_rate, target_sampling_rate)

    segment_length = target_sampling_rate * 3
    segments = split_audio(downsampled_audio, segment_length)
    
    for segment in segments:
        spectrogram = librosa.feature.melspectrogram(y=segment, sr=target_sampling_rate)

        spectrogram_db = librosa.power_to_db(spectrogram, ref=np.max)

        plt.figure(figsize=(1.28, 1.28))
        librosa.display.specshow(spectrogram_db, sr=target_sampling_rate)
        plt.savefig('spectrogram.png', transparent=True)
        plt.close()

        img = Image.open('spectrogram.png').convert('RGB')
        img_arr = np.asarray(img)
        img_arr = img_arr / 255

        img_arr = img_arr.reshape(1, 128, 128, 3)

        prediction = model.predict(img_arr)
        x = np.argmax(prediction)
        confidence = prediction[0, x]
        heart_class.append(d[x])
        heart_confidence.append(confidence)
        os.remove('spectrogram.png')

    predicted_class = heart_class[heart_confidence.index(max(heart_confidence))]
    print(predicted_class)
    return predicted_class

@app.route('/plot', methods=['GET'])
def plot():
    return send_file(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\imgplot.png", mimetype='image/png')

@app.route('/specplot', methods=['GET'])
def specplot():
    return send_file(r"C:\Users\Rashiqua Munshi\Desktop\HeartPS2\specshow.png", mimetype='image/png')

if __name__ == '__main__':
    app.run(debug=True)