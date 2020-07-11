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
							printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return CLASS;
						}
"create"					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return CREATE;
						}
"do" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return DO;
						}
"end" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return END;
						}
"feature"					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return FEATURE;
						}
"local"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return LOCAL;
						}
"print"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Function", line, col);
							col += yyleng;
							yylval = line;
							return PRINT;
						}
"if"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return IF;
						}
"then"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return THEN;
						}
"else"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return ELSE;
						}
"elseif"					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return ELSEIF;
						}
":=" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return ASSIGN;
						}
"from" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return FROM;
						}
"until" 					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return UNTIL;
						}
"loop" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return LOOP;
						}
"inspect" 					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return INSPECT;
						}
".." 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return DOTS;
						}
"|..|" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
							yylval = line;
							return PIPEDOTS;
						}
"variant" 					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return VARIANT;
						}
"invariant" 					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return INVARIANT;
						}
"when" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
							yylval = line;
							return WHEN;
						}
"*" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return MUL;
						}
"/" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return DIV;
						}
"+" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return ADD;
						}
"-" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Mathematical Operators", line, col);
							col += yyleng;
							yylval = line;
							return SUB;
						}
"not" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return NOT;
						}
"true"|"false"					{
printf("%s ", yytext);
							addHashUtil(yytext, "Boolean Literal", line, col);
							col += yyleng;
							yylval = line;
							return BOOLEAN;
						}
"and"		 				{
printf("%s ", yytext);
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return AND;
						}
"or" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return OR;
						}
"xor" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Logical Operators", line, col);
							col += yyleng;
							yylval = line;
							return XOR;
						}
"<"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return LT;
						}
">"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return GT;
						}
"<="						{
printf("%s ", yytext);
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return LTEQ;
						}
">="						{
printf("%s ", yytext);
							addHashUtil(yytext, "Comparison Operators", line, col);
							col += yyleng;
							yylval = line;
							return GTEQ;
						}
"," 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return COMMA;
						}
":"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return COLON;
						}
";"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return SEMICOLON;
						}
"(" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return OP;
						}
")" 						{
printf("%s ", yytext);
							addHashUtil(yytext, "Delimiters", line, col);
							col += yyleng;
							yylval = line;
							return CP;
						}
"="|"~"						{
printf("%s ", yytext);
							addHashUtil(yytext, "Operators", line, col);
							col += yyleng;
							yylval = line;
							return EQUAL;
						}
{integer}					{
printf("%s ", yytext);
							addHashUtil(yytext, "Integer", line, col);
							col += yyleng;
							yylval = line;
							return INTEGER;
						}
{real}						{
printf("%s ", yytext);
							addHashUtil(yytext, "Real No.", line, col);
							col += yyleng;
							yylval = line;
							return REAL;
						}
{string}					{
printf("%s ", yytext);
							addHashUtil(yytext, "String", line, col);
							col += yyleng;
							yylval = line;
							return STRING;
						}
{keyword}					{
printf("%s ", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							yylval = line;
							col += yyleng;
							return KEYWORD;
						}
{predefined_types}				{
printf("%s ", yytext);
							addHashUtil(yytext, "Predefined Type", line, col);
							yylval = line;
							col += yyleng;
							return DATATYPE;
						}
{specialOperator}				{
printf("%s ", yytext);
							addHashUtil(yytext, "Special Operator", line, col);
							yylval = line;
							col += yyleng;
						}
{identifier}					{
printf("%s ", yytext);
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
printf("%s ", yytext);
							col += yyleng;
						}
{operator}					{
printf("%s ", yytext);
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
