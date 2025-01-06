#ifndef GrayRenderer_hpp
#define GrayRenderer_hpp

#include "Renderer.hpp"

class GrayRenderer : public Renderer {
public:
    void setup(int size, AudioReader &reader, float brightness) override;
    void update() override;
};

#endif // GrayRenderer_hpp
