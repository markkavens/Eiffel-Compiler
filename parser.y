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
