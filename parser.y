%{
  #include <stdio.h>
  #include <stdlib.h>
  int yylex();
  void yyerror(char* s);
  extern int col;
%}

%token INTEGER REAL STRING ARRAYED_LIST BOOLEAN CHARACTER DOUBLE
%token OP CP OSB CSB COLON SEMICOLON EQUAL ASSIGN
%token REQUIRE ENSURE INVARIANT VARIANT
%token CLASS CREATE FEATURE
%token IDENTIFIER
%token DO END
%token DATATYPE
%token IF THEN ELSEIF ELSE INSPECT WHEN COMMA
%token GTEQ LT LTEQ GT NOT
%token PIPEDOTS DOTS
%token FROM UNTIL LOOP

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
              | IDENTIFIER function_head inside_function inside_feature
              | IDENTIFIER function_head if_return inside_function inside_feature
              ;

function_head:
             | OP container CP
             ;

inside_function:
               | DO code_section END

container:
         | container IDENTIFIER if_return SEMICOLON
         | container IDENTIFIER if_return
         ;

if_return: COLON DATATYPE
         ;

code_section: code_section_in
           | code_section_in code_section
           ;

code_section_in: IDENTIFIER if_return
               | condition
               | inspect_structure
               | loops
               ;

condition: if-condition elseif-condition else-condition END
         ;

if-condition: IF statement THEN code_section
            ;

elseif-condition:
                | elseif-condition ELSEIF statement THEN code_section
                ;

else-condition:
              | ELSE code_section
              ;

inspect_structure: INSPECT statement when_part_list ELSE code_section END
                 ;

when_part_list:
              | when_part_list when_part
              ;

when_part: WHEN choices THEN code_section
         ;

choices: literals
       | literals COMMA choices
       | literals DOTS literals
       ;

variable_assignments:
                    | variable_assignments variable_assignment
                    ;

variable_assignment: IDENTIFIER ASSIGN expr
                    ;

loops: FROM variable_assignment variable_assignments top_loop UNTIL statement LOOP code_section bottom_loop END
     ;

top_loop:
        | invariant_contracts
        ;

bottom_loop:
           | variant_contracts
           ;

statement: expr comparison_symbol expr
         ;

expr: IDENTIFIER
    | literals
    ;

comparison_symbol: GT
                 | GTEQ
                 | LT
                 | LTEQ
                 ;

literals: integer_literal
        | real_literal
        | string_literal
        | double_literal
        | character_literal
        | boolean_literal

integer_literal: INTEGER
               ;

real_literal: REAL
            ;

string_literal: STRING
              ;

double_literal: DOUBLE
              ;

character_literal: CHARACTER
                 ;

boolean_literal: BOOLEAN
               ;

/*require_contarct: REQUIRE contracts_expressions
                ;

ensure_contarct: ENSURE contracts_expressions
               ;*/

invariant_contracts: INVARIANT contracts_expressions
                   ;

variant_contracts: VARIANT contracts_expressions
                 ;

contracts_expressions: IDENTIFIER COLON statement
                     | statement
                     ;

%%

int main() {
  yyparse();
  printf("Syntactically Correct\n");
  return 0;
}

void yyerror(char* s) {
  printf("Error: at line %d at %d, %s\n", yylval, col, s);
  exit(0);
}
