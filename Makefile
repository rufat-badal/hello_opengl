# Project directories
SRC_DIR = src
BUILD_DIR = build
INCLUDE_DIR = /Users/rufat/Development/Includes
LIB_DIR = /Users/rufat/Development/Libs

# Compiler and linker
CC = clang
CFLAGS = -std=c17 -Wall -I$(INCLUDE_DIR)
LDFLAGS = -L$(LIB_DIR) -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit

# Project files
SOURCES = $(SRC_DIR)/main.c $(SRC_DIR)/glad.c
OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SOURCES))
TARGET = $(BUILD_DIR)/hello_opengl

# Default target
all: $(TARGET)

# Build the executable
$(TARGET): $(OBJECTS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build files
clean:
	rm -rf $(BUILD_DIR)

# Run the project
run: $(TARGET)
	./$(TARGET)
