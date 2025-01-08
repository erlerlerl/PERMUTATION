#ifndef ColorRenderer_hpp
#define ColorRenderer_hpp

#include "Renderer.hpp"

class ColorRenderer : public Renderer {
public:
    void setup(int size, float brightness) override;
    void update() override;

private:
    std::vector<float> dataG; // Grün-Kanal
    std::vector<float> dataB; // Blau-Kanal
    std::vector<float> adjustAudioData(float r, float g, float b);
};

#endif // ColorRenderer_hpp
