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
    INTEGER = 258,
    REAL = 259,
    STRING = 260,
    ARRAYED_LIST = 261,
    BOOLEAN = 262,
    CHARACTER = 263,
    DOUBLE = 264,
    OP = 265,
    CP = 266,
    OSB = 267,
    CSB = 268,
    COLON = 269,
    SEMICOLON = 270,
    EQUAL = 271,
    ASSIGN = 272,
    REQUIRE = 273,
    ENSURE = 274,
    INVARIANT = 275,
    VARIANT = 276,
    CLASS = 277,
    CREATE = 278,
    FEATURE = 279,
    IDENTIFIER = 280,
    DO = 281,
    END = 282,
    DATATYPE = 283,
    IF = 284,
    THEN = 285,
    ELSEIF = 286,
    ELSE = 287,
    INSPECT = 288,
    WHEN = 289,
    COMMA = 290,
    GTEQ = 291,
    LT = 292,
    LTEQ = 293,
    GT = 294,
    NOT = 295,
    PIPEDOTS = 296,
    DOTS = 297,
    FROM = 298,
    UNTIL = 299,
    LOOP = 300
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
