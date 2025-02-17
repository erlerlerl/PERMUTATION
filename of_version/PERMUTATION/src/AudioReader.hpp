//
//  AudioReader.hpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#ifndef AudioReader_hpp
#define AudioReader_hpp

#include <stdio.h>
#include <ofMain.h>
#include <Renderer.hpp>

class AudioReader{
  
public:
    
    ofSoundStream stream;

    
    
    std::vector<std::vector<float>> channels;
    std::mutex audioMutex;
    
    std::vector<float> data;
    
    Renderer * renderer;
    
    AudioReader();
    
    void setup(int deviceID, int sampleRate, int numInputChannels, int bufferSize, Renderer & renderer);
    
    void update();
    
    void draw();
    
    void audioIn(ofSoundBuffer &input);
    
    std::vector<float> & getChannelData(int channel);
    
    std::vector<float> getData();
    
    void sendData(std::vector<float> data);
    
    void printDevices();
    
    
    
private:
    
    
    
};

#endif /* AudioReader_hpp */
