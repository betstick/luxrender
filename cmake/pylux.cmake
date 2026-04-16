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

# SET(CMAKE_USE_PYTHON_VERSION 3.2)

IF(APPLE)
ELSE(APPLE)
	IF(PYTHON_CUSTOM)
		IF (NOT PYTHON_LIBRARIES)
			MESSAGE(FATAL_ERROR " PYTHON_CUSTOM set but PYTHON_LIBRARIES NOT set.")
		ENDIF (NOT PYTHON_LIBRARIES)
		IF (NOT PYTHON_INCLUDE_PATH)
			MESSAGE(FATAL_ERROR " PYTHON_CUSTOM set but PYTHON_INCLUDE_PATH NOT set.")
		ENDIF (NOT PYTHON_INCLUDE_PATH)
	ELSE(PYTHON_CUSTOM)
		FIND_PACKAGE(PythonLibs)
	ENDIF(PYTHON_CUSTOM)
ENDIF(APPLE)

IF(PYTHONLIBS_FOUND OR PYTHON_CUSTOM)
	MESSAGE(STATUS "Python library directory: " ${PYTHON_LIBRARIES} )
	MESSAGE(STATUS "Python include directory: " ${PYTHON_INCLUDE_PATH} )

	INCLUDE_DIRECTORIES(SYSTEM ${PYTHON_INCLUDE_PATH})

	SOURCE_GROUP("Source Files\\Python" FILES python/binding.cpp)
	SOURCE_GROUP("Header Files\\Python" FILES
		python/binding.h
		python/pycontext.h
		python/pydoc.h
		python/pydoc_context.h
		python/pydoc_renderserver.h
		python/pydynload.h
		python/pyfleximage.h
		python/pyrenderserver.h
		)

	ADD_LIBRARY(pylux MODULE python/binding.cpp)
	IF(APPLE)
	ELSE(APPLE)

		target_link_libraries(pylux PRIVATE
    		lux
    		Threads::Threads
    		Boost::python
		)
		
		SET_TARGET_PROPERTIES(pylux PROPERTIES PREFIX "")

	ENDIF(APPLE)

	ELSE(PYTHONLIBS_FOUND OR PYTHON_CUSTOM)
	MESSAGE( STATUS "Warning: could not find Python libraries - not building python module")
ENDIF(PYTHONLIBS_FOUND OR PYTHON_CUSTOM)
