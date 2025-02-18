//
//  Renderer.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "Renderer.hpp"

void Renderer::setup(int size, bool color, AudioReader & reader, float brightness){
    
    width = size;
    height = size;
    
    this->color = color;
    this->reader = & reader;
    this->brightness = brightness;
    
    data.resize(width*height);
    
    if(this->color){
        dataG.resize(width*height);
        dataB.resize(width*height);
    }
    
}

void Renderer::update(){
    
    ofPixels pixels;
    
    if(this->color){
        
        pixels.allocate(width, height, OF_PIXELS_RGB);
        
        for(int i = 0; i < height; ++i) {
            for(int j = 0; j < width; ++j) {
                
                float value = data[i * width + j];
                int idx = i*width+j;
                //ofLog()<<value;
                unsigned char pixelValue = ofMap(value, -1, 1, 0, 255);
                
                std::vector<float> c = adjustAudioData(data[idx], dataG[idx], dataB[idx]);
                
                pixels.setColor(j, i, ofColor(c[0], c[1], c[2]));
            }
        }
        
    }else{
        
        pixels.allocate(width, height, OF_PIXELS_GRAY);
        
        for(int i = 0; i < height; ++i) {
            for(int j = 0; j < width; ++j) {
                
                float value = data[i * width + j];
                //ofLog()<<value;
                unsigned char pixelValue = ofMap(value, -1, 1, 0, 255);
                
                
                pixels.setColor(j, i, ofColor(pixelValue));
            }
        }
    }
    
    texture.loadData(pixels);
    
}

void Renderer::draw(){
    
    texture.draw((ofGetWidth()-width)/2,(ofGetHeight()-height)/2);
    
}

void Renderer::updateData(){
    
    if(this->color){
        
        std::vector<float> r = reader->getChannelData(0);
        std::vector<float> g = reader->getChannelData(1);
        std::vector<float> b = reader->getChannelData(2);
        
        int size = r.size();
        data.erase(data.begin(), data.begin()+size);
        dataG.erase(dataG.begin(), dataG.begin()+size);
        dataB.erase(dataB.begin(), dataB.begin()+size);
        
        data.insert(data.end(), r.begin(), r.end());
        dataG.insert(dataG.end(), g.begin(), g.end());
        dataB.insert(dataB.end(), b.begin(), b.end());
    }else{
        std::vector<float> value = reader->getChannelData(0);
        int size = value.size();
        data.erase(data.begin(), data.begin()+size);
        data.insert(data.end(), value.begin(), value.end());
    }
}

std::vector<float> Renderer::adjustAudioData(float r, float g, float b){
    
    std::vector<float> out;
    out.resize(3);
    
    if(r>=0){
        out[0] += r;
    }else{
        out[1] -= r;
        out[2] -= r;
    }
    if(g>=0){
        out[1] += g;
    }else{
        out[0] -= g;
        out[2] -= g;
    }
    if(b>=0){
        out[2] += b;
    }else{
        out[0] -= b;
        out[1] -= b;
    }
    
    out[0] = ofClamp(ofMap(out[0], 0, 3, 0, 255)*brightness, 0, 255);
    out[1] = ofClamp(ofMap(out[1], 0, 3, 0, 255)*brightness, 0, 255);
    out[2] = ofClamp(ofMap(out[2], 0, 3, 0, 255)*brightness, 0, 255);
    
    return out;
    
}
