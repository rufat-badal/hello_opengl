CC = clang
CXX = clang++

INCLUDES = /Users/rufat/Development/Includes
LIBRARIES = /Users/rufat/Development/Libs

CFLAGS = -std=c11 -Wall -I$(INCLUDES)
CXXFLAGS = -std=c++17 -Wall -I$(INCLUDES)
LDFLAGS = -L$(LIBRARIES) -lglfw3 -framework Cocoa -framework QuartzCore -framework OpenGL -framework IOKit

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
	rm $(BUILD_DIR)/*.o
	rm $(TARGET)

run: $(TARGET)
	./$(TARGET)
