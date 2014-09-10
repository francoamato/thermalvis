SET(Qt5Widgets_DIR "C:/Qt/Qt5.3.1/5.3/msvc2012_opengl/lib/cmake/Qt5Widgets" CACHE STRING "Default search path for QtWidgets cmake file")
find_package(Qt5Widgets QUIET)

IF(Qt5Widgets_FOUND)
	IF(IS_64_BIT AND IS_WINDOWS)
		OPTION(BUILD_GUI "Build qt-based GUI controls." FALSE)
	ELSE()
		OPTION(BUILD_GUI "Build qt-based GUI controls." TRUE)
	ENDIF()
ELSE()
	OPTION(BUILD_GUI "Build qt-based GUI controls." FALSE)
ENDIF()

IF(BUILD_GUI)
	IF(IS_64_BIT AND IS_WINDOWS)
		MESSAGE(FATAL_ERROR "Qt libraries do not yet work in 64-bit mode in Windows. Please switch to 32-bit mode for this functionality, or disable the <BUILD_GUI> option.")
	ENDIF()
	find_package(Qt5Widgets)
ENDIF()

IF(BUILD_GUI AND Qt5Widgets_FOUND)
	ADD_DEFINITIONS( -D_USE_QT_ )
	string(REPLACE "." ";" Qt5Widgets_VERSION_SEP ${Qt5Widgets_VERSION})
	list(GET Qt5Widgets_VERSION_SEP 0 QT_VERSION_MAJOR)
	list(GET Qt5Widgets_VERSION_SEP 1 QT_VERSION_MINOR)
	if(POLICY CMP0020)
		cmake_policy(SET CMP0020 NEW)
	endif()
	
	SET(Qt_STREAMER_BUILD_DIR "build-streamer-Desktop_Qt_${QT_VERSION_MAJOR}_${QT_VERSION_MINOR}_${MSVC_ABBREVIATION_CAPS}_openGL_${ARCH_BITS}bit-Debug")
	SET(QTSTREAMER_BUILD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/qt/${Qt_STREAMER_BUILD_DIR}" CACHE STRING "Build directory for Qt streamer app")
	SET(Qt_FLOW_BUILD_DIR "build-flow-Desktop_Qt_${QT_VERSION_MAJOR}_${QT_VERSION_MINOR}_${MSVC_ABBREVIATION_CAPS}_openGL_${ARCH_BITS}bit-Debug")
	SET(QTFLOW_BUILD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/qt/${Qt_FLOW_BUILD_DIR}" CACHE STRING "Build directory for Qt flow app")
	SET(Qt_SLAM_BUILD_DIR "build-slam-Desktop_Qt_${QT_VERSION_MAJOR}_${QT_VERSION_MINOR}_${MSVC_ABBREVIATION_CAPS}_openGL_${ARCH_BITS}bit-Debug")
	SET(QTSLAM_BUILD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/qt/${Qt_SLAM_BUILD_DIR}" CACHE STRING "Build directory for Qt slam app")
	#LIST(APPEND ADDITIONAL_LIBRARIES Qt5::WinMain)
ELSEIF(BUILD_GUI)
	MESSAGE(FATAL_ERROR "Qt5 was not found. Please check that the <Qt5Widgets_DIR> variable points to the location of <Qt5WidgetsConfig.cmake>. If you want to build without the GUI, please deselect the option <BUILD_GUI>")
ENDIF()