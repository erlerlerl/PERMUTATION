//
//  AudioReader.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "AudioReader.hpp"

AudioReader::AudioReader(){};

void AudioReader::setup(int deviceID, int sampleRate, int numInputChannels, int bufferSize, Renderer & renderer){
    
    this->renderer = &renderer;
    
    auto devices = stream.getDeviceList();
    
    for(const auto &device : devices){
        
        ofLog()<< device;
        ofLog() << "  API: " << device.api;
        
    }
    
    ofSoundStreamSettings settings;
    
    
    settings.setInDevice(devices[deviceID]);
    settings.setInListener(this);
    settings.sampleRate = sampleRate;
    settings.numInputChannels = numInputChannels;
    settings.bufferSize = bufferSize;
    
    stream.setup(settings);
    
    for(int i = 0; i<numInputChannels; i++){
        
        channels.push_back(std::vector<float>());
        
    }
    
    for(auto & channel : channels){
        
        channel.assign(settings.bufferSize, 0.0);
        
    }

    
    
    
}

void AudioReader::update(){
    
    
  
    
}

void AudioReader::draw(){
    
    
}

void AudioReader::audioIn(ofSoundBuffer &input){
    
    std::lock_guard<std::mutex> lock(audioMutex);
    
    
    data = input.getBuffer();
    
    //ofLog()<<"actual audioBufferSize: "<<data.size();
    
    
    for(size_t i = 0; i < input.getNumFrames(); i++){
        
        
        
        
        for(int j = 0; j < channels.size(); j++){
            
            channels[j][i] = input.getSample(i,j);
        }
        
    }
    
    
    
    sendData(data);
    
}

std::vector<float> & AudioReader::getChannelData(int channel){
    return channels[channel];
}

std::vector<float> AudioReader::getData(){
    
    std::vector<float> outData;
    
    for(int i = 0; i<channels.size(); i++){
        for(int j = 0; j<channels[i].size(); j++){
            
            outData.push_back(channels[i][j]);
            
        }
    }
    
    //ofLog()<<data.size();
    
    return data;
    
}

void AudioReader::sendData(std::vector<float> data){
    
    
    this->renderer->updateData(data);
    
}

void AudioReader::printDevices(){
    
    
    
}
