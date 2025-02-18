# PERMUTATION

On the top-level PERMUTATION resembles a tool for realtime visualization of sound-streams. Depending on the activated [Rendering Engine](#rendering-engines) digital audio channels get mapped to pixel values of a frame.  It is used to explore different aspects of associative correspondene accross data representation.

## Conceptual Background

After exploring the possibilities of distorting images via auditive processing inside of [Audacity](https://www.audacityteam.org) we were looking for a more performative approach to databending. The goal was to create a framework in which we can alter any kind of data by sonic means and not only listening to the results but also displaying them on a screen. PERMUTATION offers a solution to this approach.

In correspondence with the ideas of objects, their labels and their representation developed by René Magritte (cf. [La trahison des images](https://en.wikipedia.org/wiki/The_Treachery_of_Images)) PERMUTATION questions the relationship between data and its representation.

## Usage

PERMUTATION is meant to be used as a performative tool for live visualization of sonic data. The source of the sonic data is irrelevant as long as the data is formatted as a stable soundstream. Suggestions for sourcing data can be found under [Soundstream Options](#soundstream-options).

### Installation

There are two versions of the PERMUTATION engine available in this repository. The older version programmed as a python script and an openFrameworks project. The openFrameworks version is strongly recommended as it is the current version which not only has the full functionality of the python version but offers more features including different types of [Rendering Engines](#rendering-engines). 

Important to note is that the python version uses PyAudio to access the soundstream and openCV to create the frame, so make sure to have these dependencies installed and working.

The openFrameworks version should be importable by the openFrameworks projectGenerator App. It does not require the installation of any external dependencies apart from openFrameworks itself.

#### IMPORTANT

The python version is deprecated and will no longer be developed. The following sections describe the usage of the openFrameworks version.

### Parameters

Before running the code you need to set some parameters inside of the **ofApp**'s `ofApp::setup()` function. The parameters are devided into three Blocks (Soundstream, Videostream, Display).

- Soundstream
    1. `devideID` should be set to the ID of the sound device you want to listen to. A list of available sound devices is printed into the console when running the program.
    2. `sampleRate` should be set to the devices sampleRate to guarantee an accurate interpretation of the soundstream.
    3. `numInputChannels` specifies the number of input the channels you want to listen to. Your device needs to provide the amount specified here or else the program will crash. All the renderers have a standard functionality when provided with the right amount of sound channels. Further information in the [Rendering Engines](#rendering-engines) section.
    4. `bufferSize` should ideally be set to the size of your frame or there could emerge some synchronization problems. Further information in the [Associative Limitations](#associative-limitations) section.

- Videostream
    1. `frameRate` can be set more or less freely. Can be used to create interesting aliasing artifacts when set to special frequencies. Further information in the [Associative Limitations](#associative-limitations) section.
    2. `frameSize` resembles the size of the frame thats calculated, not (!) the size of the displayed frame. Should ideally correspond to the `bufferSize`.
    3. `scale` is used to scale the calculated frame to fit any type of screen.
    4. `fullscreen` is used to specify whether the program should start in full screen.

- Display
    1. `colorMode` currently not used.
    2. `brightness` is used to brighten up the frame. Usefull, when the soundstream only provides low values and you don't have an option to adjust the gain of the soundstream.


### Rendering Engines

There are currently three available rendering Engines. These are the GrayRenderer, the ColorRenderer and the RowRenderer.
The GrayRenderer and ColorRenderer work in similar ways. Both take a Soundstream as input and map the samplevalues onto the pixel values from left to right. They always write the last row of the frame. For every row written this way, the first row of the frame gets removed, so that the written pixels move up while running the code.

#### GrayRenderer

The GrayRenderer is designed to accept one audio channel and maps every new sample on one pixel therefore creating a grayscale image. The Renderer needs to calculate an unsigned 8 bit Integer out of the incoming soundstream values. This is achieved with linear scaling according to the following formula:

![Formula](https://latex.codecogs.com/png.latex?x_{\text{pixel}}%20%3D%20%5Cfrac%7B(x_{\text{sample}}%20%2B%201)%20%5Ctimes%20255%7D%7B2%7D)

This mapping poses associative limitations in it of itself as described in [Associative Limitations](#signal-polarity).

#### ColorRenderer

The ColorRenderer differs in two aspects from the GrayRenderer. The logic of always writing the last row and removing the first remains the same, however this time the engine writes 3 values per pixel to collect enough data for an rgb8 image. So for each three values of the soundstream one pixel is written or in term of indexes:

![Formula](https://latex.codecogs.com/png.latex?i_{\text{pixel}}%20%3D%20i_{\text{sample}}%20%2F%2F%203)

It is recommended to use multichannel audio data while working with the ColorRenderer. Using 3 audio channels in interleaved format means, that each audio channel describes the value of one specific color channel (red, green and blue).

The ColorRenderer proposes a solution for the mapping problem concering the [GrayRenderer](#grayrenderer), explained in the [Associative Limitations](#signal-polarity) chapter.




### Soundstream Options

Different possibilites of providing a stable soundstream can be:
- Realtime sound synthesis
- Live input of instruments
- Live-coded sound
- Using the raw data of any type of file inside of a looped soundbuffer

### Associative Limitations

The described limitations mainly refer to an auditive data source.

#### Frequential Dependencies

A main limitation of visualizing audio signals lies within the nature of sound itself.
While we percieve a sinewave with a certain frequency (at least ~30 Hz) as a still standing tone the signal itself describes a time-based modulation of the values of the soundstream. While the percieved tone is not changing, the signal itself needs to change constantly.
The PERMUTATION rendering engines visualize the sound pixel by pixel for each row before jumping into the next row.

This causes a problem for the visualization of the signal. However there are ways of guaranteeing the associative correspondence. If you adjust the visualization in a way that every frame shows exactly (sample–accurate) *n* periods of the sinewave, it appears to be standing still.
For performative reasons it often appears to be easier to adjust the frequency of the sonic material to the framewidth, instead of the other way around.
So to deal with the associative limitations we decided on *main frequencies* which we were going to use in the performance to create and modulate sound.
We formulated two *main frequencies*. One *f<sub>h</sub>* which one period of a periodic sound wave fills exactly one row of our frame, so that the frequency matches the width.
The other one *f<sub>v</sub>* so one period matches the height and therefore the whole frame.

These freqencies can be calculated with the following formulas:

![Formula](https://latex.codecogs.com/png.latex?f_{h}=\frac{\text{sampleRate}}{\text{frameWidth}})

![Formula](https://latex.codecogs.com/png.latex?f_{v}=\frac{\text{sampleRate}}{\text{frameWidth}\cdot\text{frameHeight}})

Or with a square-shaped frame:

![Formula](https://latex.codecogs.com/png.latex?f_{h}=\frac{\text{sampleRate}}{\text{frameSize}})

![Formula](https://latex.codecogs.com/png.latex?f_{v}=\frac{\text{sampleRate}}{\text{frameSize}^2})

#### Signal Polarity

Another major associative limitation derives from the polarity of signal-interpretation. While auditive interpretation of signals is conventionally based on a bipolar signal, due to the physical nature of sound, visual data is commonly treated unipolar. Working on the first iterations of PERMUTATION we wanted to achieve a correlation between silence in sound and darkness in visuals. It seemed like an obvious association that no sound at all should lead to a black frame on the screen (which is debatable). Using a linear mapping between a bipolar and unipolar datastream, like the one that the [GrayRenderer](#grayrenderer) uses, poses a challenge to this correlation. Simply offsetting (and scaling) a bipolar signal to depolarize it, means that a bipolar signal with value 0 will be set to half the maximum value of the scaled unipolar signal. This can be experienced using the GrayRenderer. When no sound is inputed, the frame resembles a gray color with pixel-value of 127 (half of the maximum 255 of an 8-bit unsigned integer).



