-- http://industriousone.com/scripting-reference

local action = _ACTION or ""

local OPENCV_PATH   = "d:/opencv/build"

solution "openpose"
    location (action)
    configurations { "Debug", "Release" }
    platforms {"x64"}
    language "C"
    kind "StaticLib"

    filter "system:windows"
        defines { 
            "_CRT_SECURE_NO_WARNINGS",
            "WIN32",
            "_TIMESPEC_DEFINED",
            "OPENCV",
            "CV_IGNORE_DEBUG_BUILD_GUARD",
        }

    configuration "x64"
        libdirs {
            "../bin",
            path.join(OPENCV_PATH, "x64/vc14/lib")
        }
        targetdir ("../bin/")

    configuration "Debug"
        defines { "DEBUG" }
        symbols "On"
        targetsuffix "-d"

    configuration "Release"
        defines { "NDEBUG" }
        flags { "No64BitChecks" }
        editandcontinue "Off"
        optimize "Speed"
        optimize "On"
        editandcontinue "Off"

    project "openpose"
        kind "ConsoleApp"
        includedirs {
            "../darknet/3rdparty/include",
            "../darknet/src",
            "src",
            path.join(OPENCV_PATH, "include")
        }
        files { 
            "src/**",
        }
        configuration "Debug"
            links {
                "opencv_world340d.lib",
                "yolo_cpp_dll.lib",
            }
        configuration "Release"
            links {
                "opencv_world340.lib",
                "yolo_cpp_dll.lib",
            }
