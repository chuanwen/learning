all: echo

clean:
	rm -f echo echo.c

echo.c: echo.l
	flex -o echo.c echo.l

echo: echo.c
	gcc echo.c -o echo

