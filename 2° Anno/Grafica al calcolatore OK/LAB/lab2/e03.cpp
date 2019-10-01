// win : CL /MD /Feapp /Iinclude e03.cpp /link /LIBPATH:lib\win /NODEFAULTLIB:MSVCRTD
// osx : c++ -std=c++11 -o app e03.cpp -I ./include -L ./lib/mac -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo
// lin : c++ -std=c++0x -o app e03.cpp -I ./include -L./lib/lin -Wl,-rpath,./lib/lin/ -lglfw -lGL
// l32 : c++ -std=c++0x -o app e03.cpp -I ./include -L./lib/lin32 -Wl,-rpath,./lib/lin32/ -lglfw -lGL

#include <cstdlib>
#include <iostream>
#include <vector>

#ifdef _WIN32
#include <GL/glew.h>
#else
#define GLFW_INCLUDE_GLCOREARB
#define GL_GLEXT_PROTOTYPES
#endif

#include <GLFW/glfw3.h>
#include <lodepng.hpp>

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
	if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
		glfwSetWindowShouldClose(window, GL_TRUE);
}

// Shader sources
/*
	oltre ai dati usati in precedenza vengono passate anche le coordinate della texture
*/
const GLchar* vertexSource =
#if defined(__APPLE_CC__)
	"#version 150 core\n"
#else
	"#version 130\n"
#endif
	"in vec2 position;"
	"in vec2 coord;"
	"out vec2 Coord;"
	"void main() {"
	"	Coord = coord;"
	"	gl_Position = vec4(position, 0.0, 1.0);"
	"}";
/*
	texture e' la funzione per ottenere un sample (rgba) date le coordinate e un sampler(2D nel nostro caso)
	uniform sampler2D contiene l'indice di texture unit da cui ottenere i dati
	il colore finale e' calcolato modulando il sample della texture per il colore interpolato tra i vertici
*/
const GLchar* fragmentSource =
#if defined(__APPLE_CC__)
	"#version 150 core\n"
#else
	"#version 130\n"
#endif
	"in vec2 Coord;"
	"out vec4 outColor;"
	"uniform sampler2D textureSampler;"
	"void main() {"
	" outColor = texture2D(textureSampler, Coord);"	
	"}";

const GLfloat vertices[] = {
//	Position	Texcoords  int
	-0.5f,  0.5f, 0.0f, 0.0f,// Top-left
	 0.5f,  0.5f, 1.0f, 0.0f, // Top-right
	 0.5f, -0.5f, 1.0f, 1.0f,  // Bottom-right
	-0.5f, -0.5f, 0.0f, 1.0f// Bottom-left
};
const GLuint elements[] = {
	0, 1, 2,
	2, 3, 0
};

GLuint vao;
GLuint vbo;
GLuint ibo;
GLuint shaderProgram;
GLuint texture;

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

	// shaderProgram must be already initialized
	GLint posAttrib = glGetAttribLocation(shaderProgram, "position");
	glEnableVertexAttribArray(posAttrib);
	glVertexAttribPointer(posAttrib, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), 0);


	GLint cooAttrib = glGetAttribLocation(shaderProgram, "coord");
	glEnableVertexAttribArray(cooAttrib);
	glVertexAttribPointer(cooAttrib, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (void*)(2 * sizeof(GLfloat)));
}

void destroy_vao()
{
	glDeleteBuffers(1, &ibo);
	glDeleteBuffers(1, &vbo);

	glDeleteVertexArrays(1, &vao);
}

/*
	carica da file l'immagine che andremo ad utilizzare come texture per il quadrato a schermo
	la lettura viene fatta utilizzando lodepng
*/
void initialize_texture()
{
	glGenTextures(1, &texture);
	std::vector<unsigned char> image;
	unsigned width, height;

	unsigned error = lodepng::decode(image, width, height, "image.png");
	if(error) std::cout << "decode error " << error << ": " << lodepng_error_text(error) << std::endl;

	// il bind della texture avverra' sulla texture unit numero 0 (l'indice che dovra' essere passato agli shader)
	glActiveTexture(GL_TEXTURE0);
	glBindTexture(GL_TEXTURE_2D, texture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image.data());
	// shaderProgram must be already initialized
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

/*
	cancella la texture e tutti i parametri associati dalla memoria grafica
	la copia caricata in ram era gia' stata cancellata automaticamente al termine dell'inizializzazione
*/
void destroy_texture()
{
	glDeleteTextures(1, &texture);
}

void draw(GLFWwindow* window)
{
	int width, height;
	glfwGetFramebufferSize(window, &width, &height);

	glViewport(0, 0, width, height);
	glClear(GL_COLOR_BUFFER_BIT);
	
	glUseProgram(shaderProgram);
	// durante l'inizializzazione abbiamo attivato la texture unit 0 e bindato la nostra texture
	// nel caso in cui avessimo piu' di una texture questo e' il punto in cui collegare quella desiderata
	glUniform1i(glGetUniformLocation(shaderProgram, "textureSampler"), 0);
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

	initialize_shader(); check(__LINE__);
	initialize_vao(); check(__LINE__);
	initialize_texture(); check(__LINE__);

	while(!glfwWindowShouldClose(window))
	{
		draw(window); check(__LINE__);

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	destroy_vao(); check(__LINE__);
	destroy_shader(); check(__LINE__);
	destroy_texture(); check(__LINE__);

	glfwDestroyWindow(window);

	glfwTerminate();
	return EXIT_SUCCESS;
}
