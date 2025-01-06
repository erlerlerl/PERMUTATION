#ifndef Renderer_hpp
#define Renderer_hpp

#include <vector>
#include <ofMain.h>
#include "AudioReader.hpp"

class Renderer {
public:
    virtual void setup(int size, AudioReader &reader, float brightness) = 0;
    virtual void update() = 0;
    virtual void draw();
    
    virtual void updateData();
    
protected:
    ofTexture texture;
    std::vector<float> data;
    int width = 512;
    int height = 512;
    float brightness = 1.0;
    AudioReader* reader;
    
    
};

#endif // Renderer_hpp
