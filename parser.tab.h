/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    shift = 258,
    INTEGER = 259,
    REAL = 260,
    STRING = 261,
    ARRAYED_LIST = 262,
    BOOLEAN = 263,
    CHARACTER = 264,
    DOUBLE = 265,
    OP = 266,
    CP = 267,
    OSB = 268,
    CSB = 269,
    COLON = 270,
    SEMICOLON = 271,
    EQUAL = 272,
    ASSIGN = 273,
    REQUIRE = 274,
    ENSURE = 275,
    INVARIANT = 276,
    VARIANT = 277,
    CLASS = 278,
    CREATE = 279,
    FEATURE = 280,
    KEYWORD = 281,
    IDENTIFIER = 282,
    DO = 283,
    END = 284,
    DATATYPE = 285,
    IF = 286,
    THEN = 287,
    ELSEIF = 288,
    ELSE = 289,
    INSPECT = 290,
    WHEN = 291,
    COMMA = 292,
    GTEQ = 293,
    LT = 294,
    LTEQ = 295,
    GT = 296,
    PIPEDOTS = 297,
    DOTS = 298,
    FROM = 299,
    UNTIL = 300,
    LOOP = 301,
    ADD = 302,
    SUB = 303,
    MUL = 304,
    DIV = 305,
    AND = 306,
    OR = 307,
    XOR = 308,
    NOT = 309,
    PRINT = 310
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
