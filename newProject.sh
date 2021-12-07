#!/bin/bash

if [ $# == 2 ]
then 
	namedir=$1
	exename=$2
	if [ -d "$namedir" ]
	then
		echo "$namedir exists"
	else
		mkdir $namedir
	fi
	cd $namedir
	if [ -f "Makefile" ]
	then
		echo "Makefile exists"
	else
		touch Makefile
		echo "NAME = $exename\nCC = gcc\nCFLAGS = -Wall -Wextra -Werror\n" >> Makefile
		echo "SRCS =  srcs/main.c\n" >> Makefile
		echo 'OBJS = ${SRCS:.c=.o}\nall: ${NAME}\n' >> Makefile
		echo '${NAME}: ${OBJS}\n\t${CC} ${CFLAGS} -I includes ${OBJS} -o ${NAME}\n' >> Makefile
		echo 'fclean: clean\n\trm -f ${NAME}\n' >> Makefile
		echo 'clean:\n\trm -f ${OBJS}\n' >> Makefile
		echo 're: fclean clean all' >> Makefile
	fi
	if [ -d "srcs" ]
	then
		echo "srcs exists" 
	else
		mkdir srcs
	fi
	if [ -f "srcs/main.c" ]
	then
		echo "srcs/main.c exists"
	else
		touch srcs/main.c
		echo "#include \"../includes/$exename.h\"\n" >> srcs/main.c
		echo 'int	main(int argc, char *argv[])\n{\n\t(void) argc;\n\t(void) argv;\n\tprintf("Hello World !!!\\n");\n}' >> srcs/main.c
	fi
	if [ -d "includes" ]
	then
		echo "includes exists" 
	else
		mkdir includes
	fi
	if [ -f "includes/$exename.h" ]
	then
		echo "includes/$exename.h exists" 
	else
		touch includes/$exename.h
		printf "#ifndef " >> includes/$exename.h
		printf "$exename" | tr "[:lower:]" "[:upper:]" >> includes/$exename.h
		printf "_H\n" >> includes/$exename.h
		printf "# define " >> includes/$exename.h
		printf "$exename" | tr "[:lower:]" "[:upper:]" >> includes/$exename.h
		printf "_H\n" >> includes/$exename.h
		echo "\n# include <stdio.h>" >> includes/$exename.h
		printf "\n#endif" >> includes/$exename.h
	fi
else
	echo "usage : sh mewProject <name of folder> <name of execfile>"
fi