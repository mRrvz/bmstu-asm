CC := LM
NAME := app.exe
FILES := $(wildcard src/*.ASM)

app.exe: $(FILES)
	$(CC) $^ -o $(NAME)

run: app.exe
	./app.exe

clean:
	rm *.OBJ *.exe
