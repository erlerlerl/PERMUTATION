//
//  Renderer.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "Renderer.hpp"

void Renderer::setup(int size, bool color, AudioReader & reader){
    
    width = size;
    height = size;
    
    this->color = color;
    this->reader = & reader;
    //still needs work -> for now generates random values. Will need to read data from AudioReader
    
    data.resize(width*height);
    
    if(this->color){
        dataG.resize(width*height);
        dataB.resize(width*height);
    }
    
        
        // Fill with random values (simulate your data)

        // Allocate texture
        ofPixels pixels;
    
    /*if(this->color){
        pixels.allocate(width, height, OF_PIXELS_RGB);
    }else{
        pixels.allocate(width, height, OF_PIXELS_GRAY);
    }
          // Grayscale image

        // Convert 1D array into pixel data
        for(int i = 0; i < height; ++i) {
            for(int j = 0; j < width; ++j) {
                
                float value = data[i * width + j];
                unsigned char pixelValue = ofMap(value, 0, 1, 0, 255);
                
                
                pixels.setColor(j, i, ofColor(pixelValue));
            }
        }

       
        texture.loadData(pixels);*/
    
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
                
                
                pixels.setColor(j, i, ofColor(ofMap(data[idx], -1, 1, 0, 255),
                                              ofMap(dataG[idx], -1, 1, 0, 255),
                                              ofMap(dataB[idx], -1, 1, 0, 255)));
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
    
    //update data based on reader->getData()
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
