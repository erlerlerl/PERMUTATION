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
#include <AudioReader.hpp>

class Renderer{
    
public:
    
    void setup(int size, bool color, AudioReader & reader);
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
    AudioReader * reader;
    

    
};

#endif /* Renderer_hpp */
