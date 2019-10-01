CPP = g++ 

LDLIBS = -I ./include -L ./lib/mac -lglfw3
FRAMEWORK = -framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo
STD = -std=c++17

WARNING = -pedantic -Wall -Wextra

.phony: all clean

.cpp:
	$(CPP) $(STD) $(WARNING) -o $@ $@.cpp $(LDLIBS) $(FRAMEWORK)




