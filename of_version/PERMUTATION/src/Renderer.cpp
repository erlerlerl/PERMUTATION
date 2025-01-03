//
//  Renderer.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "Renderer.hpp"

void Renderer::setup(int size){
    
    width = size;
    height = size;
    
    
    //still needs work -> for now generates random values. Will need to read data from AudioReader
    
    data.resize(width * height);  // 1D array (size = width * height)
        
        // Fill with random values (simulate your data)

        // Allocate texture
        ofPixels grayscalePixels;
        grayscalePixels.allocate(width, height, OF_PIXELS_GRAY);  // Grayscale image

        // Convert 1D array into pixel data
        for(int i = 0; i < height; ++i) {
            for(int j = 0; j < width; ++j) {
                
                float value = data[i * width + j];
                unsigned char pixelValue = ofMap(value, 0, 1, 0, 255);
                
                
                grayscalePixels.setColor(j, i, ofColor(pixelValue));
            }
        }

       
        texture.loadData(grayscalePixels);
    
}

void Renderer::update(){
    
    ofPixels grayscalePixels;
    grayscalePixels.allocate(width, height, OF_PIXELS_GRAY);
    
    for(int i = 0; i < height; ++i) {
        for(int j = 0; j < width; ++j) {
            
            float value = data[i * width + j];
            //ofLog()<<value;
            unsigned char pixelValue = ofMap(value, -1, 1, 0, 255);
            
            
            grayscalePixels.setColor(j, i, ofColor(pixelValue));
        }
    }
    
    texture.loadData(grayscalePixels);
    
}

void Renderer::draw(){
    
    texture.draw((ofGetWidth()-width)/2,(ofGetHeight()-height)/2);
    
}

void Renderer::updateData(std::vector<float> readerData){
    
    //update data based on reader->getData()
    int size = readerData.size();
    data.erase(data.begin(), data.begin()+size);
    data.insert(data.end(), readerData.begin(), readerData.end());
    
}
