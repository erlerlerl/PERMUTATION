//
//  RowRenderer.hpp
//  PERMUTATION
//
//  Created by Ricardo Rodrigues on 14.01.25.
//

#ifndef RowRenderer_hpp
#define RowRenderer_hpp

#include <stdio.h>
#include "Renderer.hpp"

class RowRenderer : public Renderer {
public:
    void setup(int size, float brightness) override;
    void update() override;
    void updateData(std::vector<float> & audioData);

private:
    std::vector<float> dataG; // Grün-Kanal
    std::vector<float> dataB; // Blau-Kanal
    std::vector<float> adjustAudioData(float r, float g, float b);
};

#endif /* RowRenderer_hpp */
