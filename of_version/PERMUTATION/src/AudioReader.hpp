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

class AudioReader{
  
public:
    
    ofSoundStream stream;

    
    
    std::vector<std::vector<float>> channels;
    std::mutex audioMutex;
    
    AudioReader();
    
    void setup(int deviceID, int sampleRate, int numInputChannels, int bufferSize);
    
    void update();
    
    void draw();
    
    void audioIn(ofSoundBuffer &input);
    
    std::vector<float> & getChannelData(int channel);
    
    std::vector<float> getData();
    
    void printDevices();
    
    
private:
    
    
    
};

#endif /* AudioReader_hpp */
