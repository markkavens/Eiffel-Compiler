%option noyywrap
%{
	#include<stdio.h>
	int line=1, col=1;
%}

keyword					 feature|class|do|end|alias|assign|once|inherit|redefine|if|create|else|require|ensure|local|invariant|Result|then|elseif|old|io.new_line|from|until|loop|across|as|create|NONE|Void|implies|note|description|author|NULL|local|Current|extend
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
{keyword}			{
					printf(" %s %s ", " Keyword", yytext);
					col += yyleng;
				}
{function}			{
					printf(" %s %s ", "Function", yytext);
					col += yyleng;
				}
{specialOperator}		{
					printf(" %s %s ", "Special Operator", yytext);
					col += yyleng;
				}
{identifier}			{
					printf(" %s %s ", "Identifier", yytext);
					col += yyleng;
				}
{integer}			{
					printf(" %s %s ", "Integer", yytext);
					col += yyleng;
				}
{real}				{
					printf(" %s %s ", "Real", yytext);
					col += yyleng;
				}
{string}			{
					printf(" %s %s ", "String", yytext);
					col += yyleng;
				}
{whitespace}			{
					/*printf(" %s %s ", "WhiteSpace", yytext);*/
					col += yyleng;
				}
{newline}			{
					/*printf(" %s %s ", "NewLine", yytext);*/
					printf("\n");
					line++;
					col=1;	
				}
{delimiter}			{
					printf(" %s %s ", "Delimiter", yytext);
					col += yyleng;
				}
{operator}			{
					printf(" %s %s ", "Operator", yytext);
					col += yyleng;
				}
{comment}			{
					printf(" %s %s ", "Comment", yytext);
					col += yyleng;
				}
[\.]				{
					printf(" %s %s ", "Dot", yytext);
				}
%%

int main() {
	yylex();
	return 0;
}