#pragma once

#ifdef _WIN32
    #ifdef __MINGW32__
        #include <windows.h>
        #include <psapi.h>
    #else
        #include <Windows.h>
        #include <Psapi.h>
    #endif
    #include <direct.h>
    #pragma comment(lib, "Psapi.lib")
#else
    #include <dlfcn.h>
    #include <link.h>
    #include <unistd.h>
    #include <sys/types.h>
    #include <cstdio>
    #include <cstdlib>
#endif

#include <inttypes.h>
#include <stdint.h>
#include <cstring>
#include <iostream>
#include <sstream>
#include <fstream>
#include <stdio.h>
#include <string>
#include <vector>
#include <filesystem>

// Platform compatibility layer for non-Windows
#ifndef _WIN32
    // Type aliases for Windows types used throughout the codebase
    typedef void* HMODULE;
    typedef void* HANDLE;
    typedef void* LPVOID;
    typedef int BOOL;
    typedef unsigned long DWORD;

    #ifndef TRUE
        #define TRUE 1
    #endif
    #ifndef FALSE
        #define FALSE 0
    #endif
    #ifndef NULL
        #define NULL nullptr
    #endif

    // MessageBox flags (no-op on Linux, messages go to stdout/stderr)
    #define MB_OK               0x00000000L
    #define MB_ICONERROR        0x00000010L
    #define MB_ICONWARNING      0x00000030L
    #define MB_ICONINFORMATION  0x00000040L

    // DLL-related constants
    #define DLL_PROCESS_ATTACH  1
    #define DLL_THREAD_ATTACH   2
    #define DLL_THREAD_DETACH   3
    #define DLL_PROCESS_DETACH  0

    struct MODULEINFO {
        void*  lpBaseOfDll;
        unsigned long SizeOfImage;
        void*  EntryPoint;
    };
#endif