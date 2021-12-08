@echo off
setlocal
set arg=0
for %%x in (%*) do Set /A arg+=1
IF NOT %arg% == 2 (
	echo "usage : sh mewProject <name of folder> <name of execfile>"
	EXIT /B
)
set upper=
set str=%2
for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined upper set "upper=%%~I"
set  "upper=%upper:~3%"
IF EXIST %1 (
	echo "%1 exists"
) ELSE (
	mkdir %1
)
IF EXIST "Makefile" (
	echo "Makefile exists"
) ELSE (
	type nul > %1/Makefile 
	echo NAME = %2 >> %1/Makefile
	echo CC = gcc >> %1/Makefile
	echo CFLAGS = -Wall -Wextra -Werror >> %1/Makefile
	echo SRCS =  srcs/main.c >> %1/Makefile
	echo OBJS = ${SRCS:.c=.o} >> %1/Makefile
	echo. >> %1/Makefile
	echo all: ${NAME} >> %1/Makefile
	echo. >> %1/Makefile
	echo ${NAME}: ${OBJS} >> %1/Makefile
	echo     ${CC} ${CFLAGS} -I includes ${OBJS} -o ${NAME} >> %1/Makefile
	echo. >> %1/Makefile
	echo fclean: clean >> %1/Makefile
	echo     rm -f ${NAME} >> %1/Makefile
	echo. >> %1/Makefile
	echo clean: >> %1/Makefile
	echo     rm -f ${OBJS} >> %1/Makefile
	echo. >> %1/Makefile
	echo re: fclean clean all >> %1/Makefile
)
IF EXIST "%1\srcs" (
	echo %1\srcs exists 
) ELSE (
	mkdir %1\srcs
)
IF EXIST "%1\srcs\main.c" (
	echo "%1\srcs\main.c exists"
) ELSE (
	type nul > %1\srcs\main.c
	echo #include "includes/%2.h" >> %1\srcs\main.c
	echo. >> %1\srcs\main.c
	echo int	main(int argc, char *argv[]^) >> %1\srcs\main.c
	echo { >> %1\srcs\main.c
	echo     (void^) argc; >> %1\srcs\main.c
	echo     (void^) argv; >> %1\srcs\main.c
	echo     printf("Hello World !!!\n"^); >> %1\srcs\main.c
	echo } >> %1\srcs\main.c
)
IF EXIST "%1\includes" (
	echo "%1\includes exists" 
) ELSE (
	mkdir %1\includes
)
IF EXIST "includes\%2.h" (
	echo "includes\%2.h exists"
) ELSE (
	type nul > %1\includes\%2.h
	echo #ifndef %upper%_H >> %1\includes\%2.h
	echo # define %upper%_H >> %1\includes\%2.h
	echo. >> %1\includes\%2.h
	echo # include ^<stdio.h^> >> %1\includes\%2.h
	echo. >> %1\includes\%2.h
	echo #endif >> %1\includes\%2.h
)