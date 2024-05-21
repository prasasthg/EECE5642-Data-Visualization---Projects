import gym
import cv2 as cv
import numpy as np
from tensorflow.keras.models import load_model
import time

model = load_model('model1/')
action_list = [[-1, 0.5, 0], [1, 0.5, 0], [0, 1, 0], [0.5, 0.5, 0], [-0.5, 0.5, 0], [0, 0, 1]]

def prediction(FRAME):
    FRAME = np.array(FRAME)/255.0
    FRAME = np.expand_dims(FRAME, axis=0)
    pred = np.argmax(model.predict(FRAME))
    return action_list[pred]

env = gym.make('CarRacing-v2', render_mode="human")
cap = cv.VideoCapture(0)

observation = env.reset()
start = time.time()
while True:
    ret, frame = cap.read()
    frame = cv.resize(frame, (224, 224))
    cv.imshow('frame', frame)
    curr = time.time()
    if curr - start > 5:
        action = prediction(frame)
        observation, reward, done, info, _ = env.step(action)
        env.render()

        if done:
            break
    if cv.waitKey(1) & 0xFF == ord('q'):
        break