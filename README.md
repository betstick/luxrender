## Installation

#### Linux

- Clone the repository `git clone --recurse-submodules https://github.com/betstick/luxrender`

- Inside the `luxrender` directory run the following: `mkdir bin`, `cd bin`, `cmake ..` `make -j32`

Note: so far this has only been tested on Arch Linux. More testing will follow.

#### Windows

Windows is not currently supported but building should be possible with tweaks.

#### MacOS

MacOS is not currently supported but building should be possible with tweaks.

#### Blender

The only versions of Blender supported are versions with Python 3.5.10. (e.g. 2.79)

## About

LuxRender is a physically based ray tracing software for generating photo-realistic images.

This repository is an attempt to unify the Lux and LuxRays repositories in order to simplify building and maintaining of the LuxRender engine. It puts the entire system under a CMake build system using external projects.