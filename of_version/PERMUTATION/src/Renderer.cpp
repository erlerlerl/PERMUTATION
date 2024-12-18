//
//  Renderer.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 18.12.24.
//

#include "Renderer.hpp"

void Renderer::setup(){
    
    //still needs work -> for now generates random values. Will need to read data from AudioReader
    
    data.resize(width * height);  // 1D array (size = width * height)
        
        // Fill with random values (simulate your data)
        for(int i = 0; i < data.size(); ++i) {
            data[i] = ofRandom(0, 1); // Values between 0 and 1 (representing grayscale)
        }

        // Allocate texture
        ofPixels grayscalePixels;
        grayscalePixels.allocate(width, height, OF_PIXELS_GRAY);  // Grayscale image

        // Convert 1D array into pixel data
        for(int i = 0; i < height; ++i) {
            for(int j = 0; j < width; ++j) {
                // Map data[i*width + j] to the range 0-255 for grayscale
                float value = data[i * width + j];
                unsigned char pixelValue = ofMap(value, 0, 1, 0, 255);  // Map to 0-255
                
                // Set pixel color at position (j, i) in the pixel array
                grayscalePixels.setColor(j, i, ofColor(pixelValue));
            }
        }

        // Load pixel data into the texture
        texture.loadData(grayscalePixels);
    
}

void Renderer::draw(){
    
    texture.draw(0,0);
    
}
