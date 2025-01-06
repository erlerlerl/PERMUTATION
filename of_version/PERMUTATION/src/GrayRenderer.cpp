#include "GrayRenderer.hpp"

void GrayRenderer::setup(int size, AudioReader &reader, float brightness) {
    this->width = size;
    this->height = size;
    this->reader = &reader;
    this->brightness = brightness;
    
    data.resize(width * height);
}

void GrayRenderer::update() {
    ofPixels pixels;
    pixels.allocate(width, height, OF_PIXELS_GRAY);

    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            float value = data[i * width + j];
            unsigned char pixelValue = ofMap(value, -1, 1, 0, 255);
            pixels.setColor(j, i, ofColor(pixelValue));
        }
    }

    texture.loadData(pixels);
}


