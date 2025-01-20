//
//  Renderer.cpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 06.01.25.
//

#include "Renderer.hpp"

void Renderer::draw(float scale) {
    texture.draw((ofGetWidth() - (width*scale)) / 2, (ofGetHeight() - (height*scale)) / 2, width*scale, height*scale);
}

void Renderer::updateData(std::vector<float> & audioData){
    
    
    //std::vector<float> readerData = reader->getData();
    
    int size = audioData.size();
    
//    ofLog()<<"reader Data size: " << size;
    
//    ofLog() << "render Data size before erase: "<<data.size();
    
    data.erase(data.begin(), data.begin()+size);
    
    //ofLog() << "render Data size after erase: " << data.size();
    
    data.insert(data.end(), audioData.begin(), audioData.end());
    
    //ofLog() << "render Data size after insert: "<<data.size();
    
    
    
    
}
