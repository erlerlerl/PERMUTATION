#include "ofApp.h"

//--------------------------------------------------------------


void ofApp::setup(){

    int deviceID = 0;
    int sampleRate = 48000;
    int numInputChannels = 3; //colorMode needs 3 channels, grayscale needs 1
    int bufferSize = 512;
    
    int frameSize = 512;
    bool colorMode = false; //mind the numInputChannels
    float brightness = 2.0;
    
    
    
    cRenderer.setup(frameSize, brightness);
    
    reader.setup(deviceID, sampleRate, numInputChannels, bufferSize, cRenderer);
    
    
    ofSetFullscreen(true);
    
    
}

//--------------------------------------------------------------
void ofApp::update(){

    reader.update();
    //cRenderer.updateData();
    cRenderer.update();
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    ofBackground(0, 0, 0);
    cRenderer.draw();
    
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
