###########################################################################
#   Copyright (C) 1998-2013 by authors (see AUTHORS.txt)                  #
#                                                                         #
#   This file is part of Lux.                                             #
#                                                                         #
#   Lux is free software; you can redistribute it and/or modify           #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation; either version 3 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
#   Lux is distributed in the hope that it will be useful,                #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#   GNU General Public License for more details.                          #
#                                                                         #
#   You should have received a copy of the GNU General Public License     #
#   along with this program.  If not, see <http://www.gnu.org/licenses/>. #
#                                                                         #
#   Lux website: http://www.luxrender.net                                 #
###########################################################################

set(LUXRAYS_VERSION_MAJOR 1)
set(LUXRAYS_VERSION_MINOR 9)

#############################################################################
#
# LuxRays Docs
#
#############################################################################

find_package(Doxygen)

if(DOXYGEN_FOUND)
	message(STATUS "Found Doxygen and generating LuxRays documentation")

	# Generate doxygen.template
	set(DOXYGEN_LUXRAYS_TEMPLATE ${CMAKE_CURRENT_SOURCE_DIR}/doxygen/luxrays.template)
	configure_file(
	  "${DOXYGEN_LUXRAYS_TEMPLATE}.in"
	  "${DOXYGEN_LUXRAYS_TEMPLATE}"
	  )

	set(DOXYGEN_LUXRAYS_INPUT ${CMAKE_CURRENT_BINARY_DIR}/../../doxygen-luxrays.conf)
	set(DOXYGEN_LUXRAYS_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/../../doc/luxrays)
	set(DOXYGEN_LUXRAYS_OUTPUT ${DOXYGEN_OUTPUT_DIR}/luxrays/html/index.html)

	message(STATUS "Doxygen LuxRays output: " ${DOXYGEN_LUXRAYS_OUTPUT})

	if(DOXYGEN_DOT_FOUND)
			message(STATUS "Found dot")
			set(DOXYGEN_DOT_CONF "HAVE_DOT = YES")
	endif(DOXYGEN_DOT_FOUND)

	add_custom_command(
		OUTPUT ${DOXYGEN_LUXRAYS_OUTPUT}
		# Creating custom doxygen-luxrays.conf
		COMMAND mkdir -p ${DOXYGEN_LUXRAYS_OUTPUT_DIR}
		COMMAND cp ${DOXYGEN_LUXRAYS_TEMPLATE} ${DOXYGEN_LUXRAYS_INPUT}
		COMMAND echo "INPUT = " ${CMAKE_CURRENT_SOURCE_DIR}/../../include/luxrays  ${CMAKE_CURRENT_SOURCE_DIR}/../../src/luxrays >> ${DOXYGEN_LUXRAYS_INPUT}
		COMMAND echo "OUTPUT_DIRECTORY = " ${DOXYGEN_LUXRAYS_OUTPUT_DIR} >> ${DOXYGEN_LUXRAYS_INPUT}
		COMMAND echo ${DOXYGEN_DOT_CONF} >> ${DOXYGEN_LUXRAYS_INPUT}
		# Launch doxygen
		COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_LUXRAYS_INPUT}
		DEPENDS ${DOXYGEN_LUXRAYS_TEMPLATE}
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../..
	)

	add_custom_target(apidoc_luxrays DEPENDS ${DOXYGEN_LUXRAYS_OUTPUT})
endif(DOXYGEN_FOUND)

###########################################################################
#
# Library project files
#
###########################################################################

set(LUXRAYS_SRCS
	core/color/color.cpp
	core/color/spd.cpp
	core/color/spds/blackbodyspd.cpp
	core/color/spds/equalspd.cpp
	core/color/spds/frequencyspd.cpp
	core/color/spds/gaussianspd.cpp
	core/color/spds/irregular.cpp
	core/color/spds/regular.cpp
	core/color/spds/rgbillum.cpp
	core/color/spds/rgbrefl.cpp
	core/color/spectrumwavelengths.cpp
	core/color/swcspectrum.cpp
	core/epsilon.cpp
	core/exttrianglemesh.cpp
	core/trianglemesh.cpp
	core/geometry/bbox.cpp
	core/geometry/matrix4x4.cpp
	core/geometry/motionsystem.cpp
	core/geometry/transform.cpp
	core/geometry/quaternion.cpp
	textures/blender_noiselib.cpp
	tools/mc.cpp
	tools/properties.cpp
	tools/ply/rply.cpp
	tools/convtest/convtest.cpp
	tools/convtest/pdiff/lpyramid.cpp
	tools/convtest/pdiff/metric.cpp
)
SOURCE_GROUP("Source Files\\LuxRays Library" FILES ${LUXRAYS_SRCS})

set(LUXRAYS_LIB_SRCS
	${LUXRAYS_SRCS}
)

add_library(luxrays STATIC ${LUXRAYS_LIB_SRCS})

TARGET_LINK_LIBRARIES(luxrays PRIVATE
        OpenImageIO::OpenImageIO
        OpenEXR::OpenEXR
		OpenEXR::Iex
        Imath::Imath
        Boost::thread
        Boost::filesystem
		Boost::iostreams
    	Boost::serialization
        Boost::python
        PNG::PNG
        JPEG::JPEG
        TIFF::TIFF
        FFTW3::fftw3
        Threads::Threads
    )


###########################################################################
#
# Predefines
#
###########################################################################

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "../lib")