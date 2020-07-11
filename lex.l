%option noyywrap
%{
	#include <string.h>
	#include <stdlib.h>
	#include "uthash.h"
	#include "parser.tab.h"

	typedef struct {
		int line_no;
		int col_no;
		char type[100];
	} Content;

	typedef struct token{
		char val[100];      /* Key */
		Content* content;
		UT_hash_handle hh;
	} Lexeme;

	void addHashUtil(char* yytext, char* type, int line, int col);
	void addHash(char* type, int line_no, char* value, int col_no);
	Lexeme* findHash(char* str);

	Lexeme* lexemes = NULL;  /* hash array */
	int line=1, col=1;
%}

keyword					 	feature|class|do|end|alias|assign|once|inherit|redefine|if|create|else|require|ensure|local|invariant|Result|then|elseif|old|io.new_line|from|until|loop|across|as|create|NONE|Void|implies|note|description|author|NULL|local|Current|extend|compare_objects|is_empty|out
predefined_types			 	integer|string|real|boolean|double|arrayed_list|character
identifier					[a-zA-Z][a-zA-Z0-9\_]*
zero						0
unsignedInteger				 	[1-9][0-9]*
integer						({zero}|{unsignedInteger})
real					 	{integer}|(integer\.?[0-9]+)
text						[^[\"]]
string					 	\"(\\.|[^"\\])*\"
newline					 	\n
whitespace				 	[\t ]+
class_name					\n
function				 	[a-zA-Z][a-zA-Z0-9\_]*[\t ]*([(][\t ]*{identifier}[\t ]*[)]|[(][\t ]*{identifier}[\t ]*[:][\t ]*({predefined_types}|{class_name})[\t ]*[)])
delimiter					"("|")"|"{"|"}"|"["|"]"|"|"|"'"|[\"]
logicOperators 				 	and|or|xor|not
semistrictLogicOperators			"and then"|"or else"|implies
specialOperator				 	{logicOperators}|{semistrictLogicOperators}
comparisonOperators			 	"<"|">"|"<="|">="|"~"
mathematicalOperators			 	"+"|"-"|"*"|"/"
operator 				 	":="|"="|"/="|"//"|"\\"|"^"|".."|"|..|"|{comparisonOperators}|{mathematicalOperators}
comment						[-][-](.)*

%%

"class"						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return CLASS;
						}
"create"					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return CREATE;
						}
"do" 						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return DO;
						}
"end" 						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return END;
						}
"feature"					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return FEATURE;
						}
"local"						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return LOCAL;
						}
"print"						{
							addHashUtil(yytext, "Function", line, col);
							col += yyleng;
							yylval = line;
							return PRINT;
						}
"if"						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return IF;
						}
"then"						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return THEN;
						}
"else"						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return ELSE;
						}
"elseif"					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return ELSEIF;
						}
":=" 						{
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return ASSIGN;
						}
"from" 						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return FROM;
						}
"until" 					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return UNTIL;
						}
"loop" 						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return LOOP;
						}
"inspect" 					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return INSPECT;
						}
".." 						{
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return DOTS;
						}
"|..|" 						{
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return PIPEDOTS;
						}
"variant" 					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return VARIANT;
						}
"invariant" 					{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return INVARIANT;
						}
"when" 						{
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return WHEN;
						}
"*" 						{
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return MUL;
						}
"/" 						{
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return DIV;
						}
"+" 						{
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return ADD;
						}
"-" 						{
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return SUB;
						}
"not" 						{
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return NOT;
						}
"true"|"false"					{
							addHashUtil(yytext, "Boolean Literal", line, col);
							col += yyleng;
							yylval = line;
							return BOOLEAN;
						}
"and"		 				{
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return AND;
						}
"or" 						{
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return OR;
						}
"xor" 						{
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return XOR;
						}
"<"						{
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return LT;
						}
">"						{
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return GT;
						}
"<="						{
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return LTEQ;
						}
">="						{
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return GTEQ;
						}
"," 						{
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return COMMA;
						}
":"						{
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return COLON;
						}
";"						{
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return SEMICOLON;
						}
"(" 						{
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return OP;
						}
")" 						{
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return CP;
						}
"="|"~"						{
							addHashUtil(yytext, "Operators", line, col);
							col += yyleng;
							yylval = line;
							return EQUAL;
						}
{integer}					{
							addHashUtil(yytext, "Integer", line, col);
							col += yyleng;
							yylval = line;
							return INTEGER;
						}
{real}						{
							addHashUtil(yytext, "Real No.", line, col);
							col += yyleng;
							yylval = line;
							return REAL;
						}
{string}					{
							addHashUtil(yytext, "String", line, col);
							col += yyleng;
							yylval = line;
							return STRING;
						}
{keyword}					{
							addHashUtil(yytext, "Keyword", line, col);
							yylval = line;
							col += yyleng;
							return KEYWORD;
						}
{predefined_types}				{
							addHashUtil(yytext, "Predefined Type", line, col);
							yylval = line;
							col += yyleng;
							return DATATYPE;
						}
{specialOperator}				{
							addHashUtil(yytext, "Special Operator", line, col);
							yylval = line;
							col += yyleng;
						}
{identifier}					{
							addHashUtil(yytext, "Identifier", line, col);
							col += yyleng;
							yylval = line;
							return IDENTIFIER;
						}
{whitespace}					{
							col += yyleng;
						}
{newline}					{
							line++;
							col=1;
						}
{delimiter}					{
							col += yyleng;
						}
{operator}					{
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
						}
{comment}					{
							addHashUtil(yytext, "Comment", line, col);
							col += yyleng;
						}
[\.]						{
							col += yyleng;
						}
%%

void addHashUtil(char* yytext, char* type, int line, int col)
{
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    temp = findHash(yytext);
    if(temp == NULL)
        addHash(type, line, yytext, col);
}

void addHash(char* type, int line_no, char* value, int col_no)
{
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    strcpy(temp->val, value);
    temp->content = (Content*)malloc(sizeof(Content));
    temp->content->line_no = line_no;
    temp->content->col_no = col_no;
    strcpy(temp->content->type, type);
    HASH_ADD_KEYPTR(hh, lexemes, temp->val, strlen(temp->val), temp);
    free(temp);
}

Lexeme* findHash(char* str)
{
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    HASH_FIND_STR(lexemes, str, temp);
    return temp;
}
