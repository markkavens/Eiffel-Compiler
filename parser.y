%{
  #include <stdio.h>
  #include <stdlib.h>
  int yylex();
  void yyerror(char* s);
%}

%token INTEGER REAL STRING ARRAYED_LIST
%token CLASS CREATE FEATURE
%token IDENTIFIER
%token DO END
%token COLON
%token DATATYPE
%token IF THEN ELSEIF ELSE
%token GTEQ LT LTEQ GT NOT

%%

program: class_declaration
       ;

class_declaration: CLASS IDENTIFIER inside_class END
                 ;

inside_class:
            | create_declaration features_declaration
            ;

create_declaration: CREATE IDENTIFIER
                  ;

features_declaration:
                    | features_declaration feature_declaration
                    ;

feature_declaration: FEATURE inside_feature
                   ;

inside_feature:
              | variable_declaration inside_feature
              ;

variable_declaration: IDENTIFIER COLON DATATYPE
                    ;



prog:code_part {  // start symbol of if
  puts("success");}
;

code_part:code  
|code code_part
;

code :
|condition
|STRING
;

condition:
if-condition elseif-condition else-condition END 
;

if-condition:
IF statement THEN code_part
;

elseif-condition:
|elseif-condition ELSEIF statement THEN code_part 
;

else-condition:
|ELSE code_part
;

statement:
IDENTIFIER comparison_symbol IDENTIFIER
|IDENTIFIER comparison_symbol literal 
|literal comparison_symbol IDENTIFIER
|literal comparison_symbol literal
;

comparison_symbol:GT
|GTEQ
|LT
|LTEQ
;

literal: 
INTEGER
|REAL
|STRING
;



%%

int main() {
  yyparse();
  printf("Syntactically Correct\n");
  return 0;
}

void yyerror(char* s) {
  printf("Error: at line %d, %s\n", yylval, s);
  exit(0);
}
