#include "ColorRenderer.hpp"

void ColorRenderer::setup(int size, float brightness) {
    this->width = size;
    this->height = size;
    //this->reader = &reader;
    this->brightness = brightness;
    
    data.resize(width * height * 3);

}

void ColorRenderer::update() {
    
    //ofLog()<<"size of one row: "<<data.size()/height;
    
    ofPixels pixels;
    pixels.allocate(width, height, OF_PIXELS_RGB);

    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            
            int idx = (i*width+j)*3;

            std::vector<float> c = adjustAudioData(data[idx], data[idx+1], data[idx+2]);

            pixels.setColor(j, i, ofColor(c[0], c[1], c[2]));
            //pixels.setColor(j,i, ofColor(data[idx]*128,data[idx+1]*128,data[idx+2]*128));
        }
    }

    texture.loadData(pixels);
}




std::vector<float> ColorRenderer::adjustAudioData(float r, float g, float b) {
    
    
    std::vector<float> out(3);
    if (r >= 0) out[0] += r;
    else { out[1] -= r; out[2] -= r; }
    if (g >= 0) out[1] += g;
    else { out[0] -= g; out[2] -= g; }
    if (b >= 0) out[2] += b;
    else { out[0] -= b; out[1] -= b; }

    out[0] = ofClamp(ofMap(out[0], 0, 3, 0, 255) * brightness, 0, 255);
    out[1] = ofClamp(ofMap(out[1], 0, 3, 0, 255) * brightness, 0, 255);
    out[2] = ofClamp(ofMap(out[2], 0, 3, 0, 255) * brightness, 0, 255);

    return out;
    
    //rot: rgb: 255 0 0 cmy: 0 / 255 / 255
    
    //audiodaten >0 rgb; <0 cmy
    //rot kanal >0 -> rot; <0 -> cyan
    //ch1 -> rot kanal -> r-werte
    //ch2 -> grün Kanal -> g-werte
    //ch3 -> blau Kanal -> b-werte
    
    //
    
    //-1,1 audio -> 0, 255 video.
    // 0 -> video 127
}
