#include <glad/glad.h>
#include <GLFW/glfw3.h>

int main(void) {
    glfwInit();
    // We will use OpenGL 3.3
    // Arm Macs also support OpenGL 4.0 and OpenGL 4.1
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}
