%option noyywrap
%{
	#include <string.h>
	#include <stdlib.h>
	#include "uthash.h" 

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
	void printHash();
	void printLines();

	Lexeme* lexemes = NULL;  /* hash array */
	int line=1, col=1;
%}

keyword					 feature|class|do|end|alias|assign|once|inherit|redefine|if|create|else|require|ensure|local|invariant|Result|then|elseif|old|io.new_line|from|until|loop|across|as|create|NONE|Void|implies|note|description|author|NULL|local|Current|extend|compare_objects|is_empty|out|make
predefined_types			 INTEGER|STRING|REAL|BOOLEANDOUBLE|ARRAYED_LIST|CHARACTER
identifier				 [a-zA-Z][a-zA-Z0-9\_]*
zero					 0
unsignedInteger				 [1-9][0-9]*
signedInteger				 ([-]|[+]){unsignedInteger}
integer					 (([-]|[+])?{zero}|{unsignedInteger}|{signedInteger})
real					 ((\+|-)?([0-9]+)(\.[0-9]+)?)|((\+|-)?\.?[0-9]+)
text					 [^[\"]]
string					 \"(\\.|[^"\\])*\"
newline					 \n
whitespace				 [\t ]+
class_name				 \n
function				 [a-zA-Z][a-zA-Z0-9\_]*[\t ]*([(][\t ]*{identifier}[\t ]*[)]|[(][\t ]*{identifier}[\t ]*[:][\t ]*({predefined_types}|{class_name})[\t ]*[)])
delimiter				 "("|")"|"{"|"}"|"["|"]"|"|"|"'"|[\"]
logicOperators 				 and|or|xor|not
semistrictLogicOperators		 "and then"|"or else"|implies
specialOperator				 {logicOperators}|{semistrictLogicOperators}
comparisonOperators			 "<"|">"|"<="|">="|"~"
mathematicalOperators			 "+"|"-"|"*"|"/"
operator 				 ":="|"="|"/="|"//"|"\\"|"^"|".."|"|..|"|{comparisonOperators}|{mathematicalOperators}
comment					 [-][-](.)*

%%
{keyword}				{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Keyword", line, col);
							col += yyleng;
						}
{predefined_types}		{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Predefined Type", line, col);
							col += yyleng;
						}
{function}				{
							// printf("%s\n", yytext);
							strtok(yytext, "(");
							addHashUtil(yytext, "Function", line, col);
							col += yyleng;
						}
{specialOperator}		{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Special Operator", line, col);
							col += yyleng;
						}
{identifier}			{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Identifier", line, col);
							col += yyleng;
						}
{integer}				{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Integer", line, col);
							col += yyleng;
						}
{real}					{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Real No.", line, col);
							col += yyleng;
						}
{string}				{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "String", line, col);
							col += yyleng;
						}
{whitespace}			{
							col += yyleng;
						}
{newline}				{
							line++;
							col=1;
						}
{delimiter}				{
							col += yyleng;
						}
{operator}				{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Operator", line, col);
							col += yyleng;
						}
{comment}				{
							// printf("%s\n", yytext);
							addHashUtil(yytext, "Comment", line, col);
							col += yyleng;
						}
[\.]					{
							col += yyleng;
						}
[:]						{
							printf("");
						}
%%

void addHashUtil(char* yytext, char* type, int line, int col) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    temp = findHash(yytext);
    if(temp == NULL)
        addHash(type, line, yytext, col);
}

void addHash(char* type, int line_no, char* value, int col_no) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
	// temp->val = value;
	strcpy(temp->val, value);
    temp->content = (Content*)malloc(sizeof(Content));
    temp->content->line_no = line_no;
    temp->content->col_no = col_no;
    // temp->content->type = type;
	strcpy(temp->content->type, type);
    HASH_ADD_KEYPTR(hh, lexemes, temp->val, strlen(temp->val), temp);
	// printf("%s with value \'%s\' found in line %d at column %d\n", temp->content->type, temp->val, temp->content->line_no, temp->content->col_no);
	printf("%10s|%10d\t|\t%5d\t|\t%-50s\t|\t%-20s|\n"," ", line, col, yytext, type);
	printLines();
    free(temp);
}

Lexeme* findHash(char* str) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    HASH_FIND_STR(lexemes, str, temp);
    return temp;
}

void printLines() {
	for(int i=0;i<133;i++) {
		if(i<10) {
			printf(" ");
			continue;
		}
		printf("-");
	}
	printf("\n");
}

void printLinesUnderScore() {
	for(int i=0;i<133;i++) {
		if(i<10) {
			printf(" ");
			continue;
		}
		printf("_");
	}
	printf("\n");
}

int main() {
	printLinesUnderScore();
	printLines();
	printf("%10s|%10s\t|\t%5s\t|\t%-50s\t|\t%-20s|\n", " ", "LineNo", "ColNo", "Token", "Type");
	printLinesUnderScore();
	printLines();
	yylex();
	return 0;
}