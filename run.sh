#!/bin/bash

if [ $# -gt 1 ]
then
	echo "Only 1 argument (input file) required"
elif [ $# -eq 0 ]
then
	echo "One argument (input file) required"
else
	gcc convert_to_lower.c -o convert_to_lower
	./convert_to_lower $1

	bison -d parser.y
	flex lex.l
	gcc parser.tab.c lex.yy.c -lfl
	./a.out < input_converted.e
fi
