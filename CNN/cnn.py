from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
from keras.optimizers import SGD, RMSprop
from keras.utils import np_utils, generic_utils
from keras.preprocessing.image import ImageDataGenerator
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from scipy import ndimage

split=0.9

def brain(filename=None):
    model = Sequential()
    model.add(Convolution2D(18, 1, 3, 3))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(poolsize=(2, 2)))
    model.add(Dropout(0.25))
    
    model.add(Convolution2D(18, 18, 3, 3))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(poolsize=(2, 2), ignore_border=False))
    model.add(Dropout(0.25))

    model.add(Flatten())
    model.add(Dense(18*6*6, 90))
    model.add(Activation('relu'))
    model.add(Dropout(0.25))

    model.add(Dense(90, 10))
    model.add(Activation('softmax'))

    sgd = SGD(lr=0.03, decay=1e-6, momentum=0.9, nesterov=True)
    rms = RMSprop()
    model.compile(loss='categorical_crossentropy', optimizer=sgd)
    if filename != None:
        model.load_weights(filename)

    return model

def train():
    #read data
    print "read data ..."
    train_data = pd.read_csv("train.csv")
    N = train_data.shape[0]
    eval_data = pd.read_csv("test.csv")
    N_pred = eval_data.shape[0]
    X = np.reshape(train_data.values[:,1:].astype('float32'),(N,1,28,28))
    y = np_utils.to_categorical(train_data.values[:,0].astype('int32'))
    X_pred = np.reshape(eval_data.values.astype('float32'),(N_pred,1,28,28))
    print "preprocessing ..."
    scale = np.max(X)
    X /= scale
    X_pred /= scale
    mean = np.std(X)
    X -= mean
    X_pred -= mean
    model = brain()
    for i in range(10000):
        model.fit(X, y, nb_epoch=1, validation_split=0.1, show_accuracy=True)
        #predictions
        p = model.predict_classes(X_pred)
        #save
        np.savetxt("pred.csv",np.transpose((range(1,28001),p)),fmt="%d",delimiter=",")
        model.save_weights("weights%s.hdf5" % i)

if __name__ == '__main__':
    train()
