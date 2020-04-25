%option noyywrap
%{
	#include "functions.h"
	int line=1, col=1;
%}

keyword					 feature|class|do|end|alias|assign|once|inherit|redefine|if|create|else|require|ensure|local|invariant|Result|then|elseif|old|io.new_line|from|until|loop|across|as|create|NONE|Void|implies|note|description|author|NULL|local|Current|extend
predefined_types         INTEGER|STRING|REAL|BOOLEANDOUBLE|ARRAYED_LIST|CHARACTER
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
delimiter				 "("|")"|"{"|"}"|"["|"]"|"|"|"'"|[\"]
logicOperators 				 and|or|xor|not
semistrictLogicOperators		 "and then"|"or else"|implies
specialOperator				 {logicOperators}|{semistrictLogicOperators}
comparisonOperators			 "<"|">"|"<="|">="|"~"
mathematicalOperators			 "+"|"-"|"*"|"/"
operator 				 ":="|":"|"="|"/="|"//"|"\\"|"^"|".."|"|..|"|{comparisonOperators}|{mathematicalOperators}
comment					 [-][-](.)*

%%
{keyword}			{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Keyword");
						col += yyleng;
					}
{predefined_types}	{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "predefined_types");
						col += yyleng;
					}
{specialOperator}	{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Special Operator");
						col += yyleng;
					}
{identifier}		{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Identifier");
						insert(yytext,line,col,"Identifier");
						col += yyleng;
					}
{integer}			{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Integer");
						col += yyleng;
					}
{real}				{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Real");
						col += yyleng;
					}
{string}			{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "String");
						col += yyleng;
					}
{whitespace}		{
						/*printf("%d\t%d\t%30s%20s\n",line,col,yytext, "WhiteSpace");*/
						col += yyleng;
					}
{newline}			{
						/*printf("%d\t%d\t%30s%20s\n",line,col,yytext, "NewLine");*/
						/*printf("\n");*/
						line++;
						col=1;	
					}
{delimiter}			{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Delimiter");
						col += yyleng;
					}
{operator}			{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Operator");
						col += yyleng;
					}
{comment}			{
						//printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Comment");
						col += yyleng;
					}
[\.]				{
						printf("%d\t%d\t%30s%20s\n",line,col,yytext, "Dot");
					}
%%

int main() {
	
	printf("%s\t%s\t%30s%20s\n","LineNo","ColNo","Token", "Type");
	printf("%s\t%s\t%30s%20s\n","---","---","-------", "-------");
	FILE *fp; 
	char filename[50]; 
	
	fp = fopen("input.e","r"); 
	yyin = fp;
	yylex();

	printSymbolTable();
	clearSymbolTable();
	return 0;


	/*
	
	printf("Enter the filename: \n"); 
	scanf("%s",filename); 
	function				 [a-zA-Z][a-zA-Z0-9\_]*[\t ]*([(][\t ]*{identifier}[\t ]*[)]|[(][\t ]*{identifier}[\t ]*[:][\t ]*({predefined_types}|{class_name})[\t ]*[)])

	{function}			{
						printf("%s\t%s\t%d\t%d\n",yytext, "Function",line,col);
						col += yyleng;
					}
	
	*/
}