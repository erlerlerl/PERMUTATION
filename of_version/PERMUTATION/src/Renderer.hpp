//
//  Renderer.hpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#ifndef Renderer_hpp
#define Renderer_hpp

#include <stdio.h>
#include <ofMain.h>
#include <algorithm>
#include <AudioReader.hpp>

class Renderer{
    
public:
    
    void setup(int size, bool color, AudioReader & reader, float brightness);
    void update();
    void draw();
    
    void updateData();
    
    ofTexture texture;
    std::vector<float> data;
    std::vector<float> dataG;
    std::vector<float> dataB;// 1D array of values (400x400)
    int width = 512;         // Image width
    int height = 512;
    bool color = false;
    float brightness = 1.0;
    AudioReader * reader;
    
    std::vector<float> adjustAudioData(float r, float g, float b);
    
private:
    
    
    
};

#endif /* Renderer_hpp */
