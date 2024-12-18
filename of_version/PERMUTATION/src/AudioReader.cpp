//
//  AudioReader.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "AudioReader.hpp"

AudioReader::AudioReader(){};

void AudioReader::setup(int deviceID, int sampleRate, int numInputChannels, int bufferSize){
    
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
    
    for(size_t i = 0; i < input.getNumFrames(); i++){
        
        for(int j = 0; j < channels.size(); j++){
            
            channels[j][i] = input.getSample(i,j);
            
        }
        
    }
    
}

std::vector<float> & AudioReader::getChannelData(int channel){
    return channels[channel];
}

void AudioReader::printDevices(){
    
    
    
}
