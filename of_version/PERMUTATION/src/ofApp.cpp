#include "ofApp.h"

//--------------------------------------------------------------


void ofApp::setup(){

    int deviceID = 0;
    int sampleRate = 48000;
    int numInputChannels = 3; //colorMode needs 3 channels, grayscale needs 1
    int bufferSize = 512;
    
    int frameRate = 60;
    int frameSize = 512;
    scale = 1.5;
    bool fullscreen = true;
    
    bool colorMode = false; //mind the numInputChannels
    float brightness = 1.0;
    
    capture = false;
    
    
    

    
    cRenderer.setup(frameSize, brightness);
    
    reader.setup(deviceID, sampleRate, numInputChannels, bufferSize, cRenderer);
    
    ofSetWindowShape(frameSize*scale, frameSize*scale);
    ofSetFrameRate(frameRate);
    ofSetFullscreen(fullscreen);
    
    
}

//--------------------------------------------------------------
void ofApp::update(){

    reader.update();
    //cRenderer.updateData();
    cRenderer.update();
    
    if(capture){
        
        static int frameNum = 0;
            ofImage img;
            img.grabScreen(0, 0, ofGetWidth(), ofGetHeight());
            img.save("frames/frame_" + ofToString(frameNum, 4, '0') + ".png");
            frameNum++;
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    ofBackground(0, 0, 0);
    cRenderer.draw(scale);
    
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
