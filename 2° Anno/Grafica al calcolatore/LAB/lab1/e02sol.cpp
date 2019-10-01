// win : CL /MD /Feapp /Iinclude e02.cpp /link /LIBPATH:lib\win /NODEFAULTLIB:MSVCRTD
// osx : c++ -std=c++11 -o app e02.cpp -I ./include -L ./lib/mac -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo
// lin : c++ -std=c++0x -o app e02.cpp -I ./include -L./lib/lin -Wl,-rpath,./lib/lin/ -lglfw -lGL
// l32 : c++ -std=c++0x -o app e02.cpp -I ./include -L./lib/lin32 -Wl,-rpath,./lib/lin32/ -lglfw -lGL

#include <cstdlib>
#include <iostream>

#ifdef _WIN32
#include <GL/glew.h>
#else
#define GLFW_INCLUDE_GLCOREARB
#define GL_GLEXT_PROTOTYPES
#endif

#include <GLFW/glfw3.h>

#if defined(_MSC_VER)
#pragma comment(lib,"user32")
#pragma comment(lib,"gdi32")
#pragma comment(lib,"opengl32")
#pragma comment(lib,"glew32")
#pragma comment(lib,"glfw3")
#endif

static void error_callback(int error, const char* description)
{
	std::cerr << description << std::endl;
}
static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
	if (key == GLFW_KEY_B && action == GLFW_PRESS)
		{
		glClearColor(	 1,0,0,0);

		}

	if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
		glfwSetWindowShouldClose(window, GL_TRUE);

}

// Shader sources
/*
	rispetto all'esercitazione precedente passiamo il colore per ogni vertice
	di default ogni input/output nel passaggio tra vertex e fragment shader viene interpolato con il modificatore "smooth"
	per l'elenco e la descrizione dei possibili modificatori https://www.opengl.org/wiki/Type_Qualifier_(GLSL)#Interpolation_qualifiers
*/
const GLchar* vertexSource =
#if defined(__APPLE_CC__)
	"#version 150 core\n"
#else
	"#version 130\n"
#endif
	"in vec2 position;"
	"in vec3 color;"
	"out vec3 Color;"
	"void main() {"
	"	Color = color;"
	"	gl_Position = vec4(position, 0.0, 1.0);"
	"}";
/*
	settiamo il colore interpolato in ingresso dal vertex shader
*/
const GLchar* fragmentSource =
#if defined(__APPLE_CC__)
	"#version 150 core\n"
#else
	"#version 130\n"
#endif
	"in vec3 Color;"
	"out vec4 outColor;"
	"void main() {"
	"	outColor = vec4(Color, 1.0);"
	"}";

GLfloat vertices[] = {
	-0.5f,  0.5f, 1.0f, 0.0f, 0.0f, // Top-left
	 0.5f,  0.5f, 0.0f, 1.0f, 0.0f, // Top-right
	 0.5f, -0.5f, 0.0f, 0.0f, 1.0f, // Bottom-right
	-0.5f, -0.5f, 1.0f, 1.0f, 1.0f  // Bottom-left
};
const GLuint elements[] = {
	0, 1, 2,
	2, 3, 0
};

GLuint vao;
GLuint vbo;
GLuint ibo;
GLuint shaderProgram;

void check(int line)
{
	GLenum error = glGetError();
	while(error != GL_NO_ERROR)
	{
		switch(error)
		{
			case GL_INVALID_ENUM: std::cout << "GL_INVALID_ENUM : " << line << std::endl; break;
			case GL_INVALID_VALUE: std::cout << "GL_INVALID_VALUE : " << line << std::endl; break;
			case GL_INVALID_OPERATION: std::cout << "GL_INVALID_OPERATION : " << line << std::endl; break;
			case GL_OUT_OF_MEMORY: std::cout << "GL_OUT_OF_MEMORY : " << line << std::endl; break;
			default: std::cout << "Unrecognized error : " << line << std::endl; break;
		}
		error = glGetError();
	}
}

void initialize_shader()
{
	GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexSource, NULL);
	glCompileShader(vertexShader);

	GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentSource, NULL);
	glCompileShader(fragmentShader);

	shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glBindFragDataLocation(shaderProgram, 0, "outColor");
	glLinkProgram(shaderProgram);

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);
}
void destroy_shader()
{
	glDeleteProgram(shaderProgram);
}

void initialize_vao()
{
	glGenVertexArrays(1, &vao);
	glBindVertexArray(vao);

	glGenBuffers(1, &vbo);
	glBindBuffer(GL_ARRAY_BUFFER, vbo);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glGenBuffers(1, &ibo);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(elements), elements, GL_STATIC_DRAW);

	// questa volta oltre alle posizioni passiamo i colori per ogni vertice
	// il layout che dobbiamo descrivere quindi e' ppccc, ppccc, ppccc...
	// dove p = position e c = color
	// shaderProgram must be already initialized
	GLint posAttrib = glGetAttribLocation(shaderProgram, "position");
	glEnableVertexAttribArray(posAttrib);
	glVertexAttribPointer(posAttrib, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), 0); // 5 sono i campi per ogni vertice

	GLint colAttrib = glGetAttribLocation(shaderProgram, "color");
	glEnableVertexAttribArray(colAttrib);
	glVertexAttribPointer(colAttrib, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (void*)(2 * sizeof(GLfloat))); // 2 sono i dati prima di quelli del colore
}

void destroy_vao()
{
	glDeleteBuffers(1, &ibo);
	glDeleteBuffers(1, &vbo);

	glDeleteVertexArrays(1, &vao);
}

void draw(GLFWwindow* window)
{
	int width, height;
	glfwGetFramebufferSize(window, &width, &height);

	glViewport(0, 0, width, height);
	glClear(GL_COLOR_BUFFER_BIT);
	
	glUseProgram(shaderProgram);
	glBindVertexArray(vao);

	glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
}

int main(int argc, char const *argv[])
{
	GLFWwindow* window;

	glfwSetErrorCallback(error_callback);

	if(!glfwInit())
		return EXIT_FAILURE;

#if defined(__APPLE_CC__)
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
#else
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);
#endif
	window = glfwCreateWindow(800, 800, "cg-lab", NULL, NULL);
	if(!window)
	{
		glfwTerminate();
		exit(EXIT_FAILURE);
	}
	glfwMakeContextCurrent(window);

#if defined(_MSC_VER)
	glewExperimental = true;
	if (glewInit() != GL_NO_ERROR)
	{
		glfwTerminate();
		exit(EXIT_FAILURE);
	}
#endif

	glfwSetKeyCallback(window, key_callback);
       glClearColor(	 0,0,1,0);
 	initialize_shader(); check(__LINE__);
	initialize_vao(); check(__LINE__);

	while(!glfwWindowShouldClose(window))
	{
		draw(window); check(__LINE__);

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	destroy_vao(); check(__LINE__);
	destroy_shader(); check(__LINE__);

	glfwDestroyWindow(window);

	glfwTerminate();
	return EXIT_SUCCESS;
}
