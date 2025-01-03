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
    
    void setup(int size);
    void update();
    void draw();
    
    void updateData(std::vector<float> readerData);
    
    ofTexture texture;
    std::vector<float> data; // 1D array of values (400x400)
    int width = 400;         // Image width
    int height = 400;
    

    
};

#endif /* Renderer_hpp */
