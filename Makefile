# Cross-platform Makefile for RLSDK-Generator
# Usage:
#   make              -> build native Linux .so library + standalone executable
#   make windows      -> cross-compile Windows .dll (requires mingw-w64)
#   make clean        -> remove build artifacts

CXX_LINUX  = g++
CXX_MINGW  = x86_64-w64-mingw32-g++
CXXFLAGS   = -std=c++17 -Wall -Wno-invalid-offsetof
INCLUDES   = -I. -IEngine -IEngine/RocketLeague

SOURCES    = $(shell find . -name "*.cpp")

# ---- Linux native build ----
LINUX_TARGET_SO  = CodeRedGenerator.so
LINUX_TARGET_EXE = CodeRedGenerator

linux: $(LINUX_TARGET_SO) $(LINUX_TARGET_EXE)

$(LINUX_TARGET_SO): $(SOURCES)
	$(CXX_LINUX) -shared -fPIC -o $@ $(CXXFLAGS) $(INCLUDES) $^ -ldl -lpthread

$(LINUX_TARGET_EXE): $(SOURCES)
	$(CXX_LINUX) -o $@ $(CXXFLAGS) $(INCLUDES) $^ -ldl -lpthread

# ---- Windows cross-compile ----
WINDOWS_TARGET = CodeRedGenerator.dll

windows: $(WINDOWS_TARGET)

$(WINDOWS_TARGET): $(SOURCES)
	$(CXX_MINGW) -shared -o $@ $(CXXFLAGS) $(INCLUDES) $^ -lpsapi -static-libgcc -static-libstdc++ -Wl,-Bstatic -lstdc++ -lpthread -Wl,-Bdynamic

# ---- Cleanup ----
clean:
	rm -f $(LINUX_TARGET_SO) $(LINUX_TARGET_EXE) $(WINDOWS_TARGET)

.PHONY: linux windows clean
.DEFAULT_GOAL := linux
