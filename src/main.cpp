#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <iostream>

void framebuffer_size_callback(GLFWwindow *window, int width, int height);
void process_input(GLFWwindow *window);

const int SCREEN_WIDTH = 1200;
const int SCREEN_HEIGHT = 900;
const float BACKGROUND_COLOR_R = 0.2f;
const float BACKGROUND_COLOR_G = 0.3f;
const float BACKGROUND_COLOR_B = 0.3f;
const float BACKGROUND_COLOR_A = 1.0f;

int main(void) {
    glfwInit();
    // We will use OpenGL 3.3
    // Arm Macs also support OpenGL 4.0 and OpenGL 4.1
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
// Apple requires the use of forward-compatible OpenGL contexts
#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

    GLFWwindow *window = glfwCreateWindow(SCREEN_WIDTH, SCREEN_HEIGHT,
                                          "Hello OpenGL", NULL, NULL);
    if (window == NULL) {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cout << "Failed to initialize GLAD" << std::endl;
    }

    std::cout << glGetString(GL_VERSION) << std::endl;

    // Adjusts the OpenGL viewport everytime the window gets resized.
    // The callback function will be also called on first display.
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    while (!glfwWindowShouldClose(window)) {
        // input
        process_input(window);

        // rendering commands
        // clear screen with a green-blueish color
        glClearColor(BACKGROUND_COLOR_R, BACKGROUND_COLOR_G, BACKGROUND_COLOR_B,
                     BACKGROUND_COLOR_A);
        glClear(GL_COLOR_BUFFER_BIT);

        // check and call events and swap buffers (double buffering)
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}

void framebuffer_size_callback(GLFWwindow *window, int width, int height) {
    glViewport(0, 0, width, height);
}

void process_input(GLFWwindow *window) {
    // Close window when ESC is pressed.
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        // This does not directly close the window.
        // When the execution arrives at the next check of
        // glfwWindowShouldClose, the window will be closed.
        glfwSetWindowShouldClose(window, true);
    }
}
