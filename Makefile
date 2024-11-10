CC = clang
CXX = clang++

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Darwin) # We must be on macOS
	LDFLAGS_OS_SPECIFIC = -framework Cocoa -framework QuartzCore -framework OpenGL -framework IOKit
else ifeq ($(UNAME_S), Linux) # We must be on Linux
	LDFLAGS_OS_SPECIFIC = -lGL -lX11 -lpthread -lXrandr -lXi -ldl
endif

INCLUDES = $(CURDIR)/deps/Includes
LIBRARIES = $(CURDIR)/deps/Libs
LDFLAGS = -L$(LIBRARIES) -lglfw3 $(LDFLAGS_OS_SPECIFIC)

CFLAGS = -std=c11 -Wall -I$(INCLUDES)
CXXFLAGS = -std=c++17 -Wall -g -I$(INCLUDES)

SRC_DIR = src
BUILD_DIR = build

CPP_SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(BUILD_DIR)/glad.o $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(CPP_SOURCES))
TARGET = $(BUILD_DIR)/hello_opengl

all: build_dir $(TARGET)

# Ensure build directory exists
build_dir:
	@mkdir -p $(BUILD_DIR)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/glad.o: $(SRC_DIR)/glad.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BUILD_DIR)/*.o
	rm -f $(TARGET)

run: $(TARGET)
	./$(TARGET)
