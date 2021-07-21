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
%token CLASS CREATE FEATURE KEYWORD LOCAL
%token IDENTIFIER
%token DO END
%token DATATYPE
%token IF THEN ELSEIF ELSE INSPECT WHEN COMMA
%token GTEQ LT LTEQ GT
%token PIPEDOTS DOTS
%token FROM UNTIL LOOP
%token ADD SUB MUL DIV
%token AND OR XOR NOT
%token PRINT

%%
/* Complete Program */
program: class_declaration
       ;

/* Check if start with class */
class_declaration: CLASS IDENTIFIER inside_class END
                 ;

/* what can be inside class */
inside_class:
            | create_declaration features_declaration
            ;

/* Constructor of class */
create_declaration: CREATE IDENTIFIER
                  ;

/* Features of class declaration can be in any number */
features_declaration:
                    | features_declaration feature_declaration
                    ;

/* Feature declaration start with keyword "feature" */
feature_declaration: FEATURE inside_feature
                   ;

/* what can be inside feature */
inside_feature:
              | IDENTIFIER function_head inside_function inside_feature
              | IDENTIFIER function_head if_return inside_function inside_feature
              ;

/* Arguments to function */
function_head:
             | OP container CP
             ;

/* what can be inside function */
inside_function:
               | local DO code_section END
	       ;

/* Declaration of local variables */
local:
     | LOCAL variable_declaration
     ;

/* Variable declaration to declare local variables */
variable_declaration:
                    | IDENTIFIER if_return variable_declaration
                    ;

/* Used to define arguments */
container:
         | IDENTIFIER if_return delimiter container
         ;

/* Arguments can be separated by semicolon or space */
delimiter:
         | SEMICOLON
         ;

/* If function is returning something */
if_return: COLON DATATYPE
         ;

/* Defferent code sections in function */
code_section: code_section_in
            | code_section_in code_section
            ;

/* What can be inside function */
code_section_in: condition
               | inspect_structure
               | loops
               | variable_assignment
               | print_function
               ;

/* Function to print on stdout in Eiffel */
print_function: PRINT OP inside_print CP
              ;

/* Arguments to print */
inside_print: possible_inside_print
            | possible_inside_print ADD inside_print
            ;

/* Arguments to print can be string literal or identifier separeted by '+' */
possible_inside_print: string_literal
                     | IDENTIFIER
                     ;

/* Conditional statements in Eiffel */
condition: if_condition elseif_condition else_condition END
         ;

/* Any number of Assignments */
variable_assignments:
                    | variable_assignments variable_assignment
                    ;

/* Assignment in Eiffel */
variable_assignment: IDENTIFIER ASSIGN expr
                   | IDENTIFIER ASSIGN string_literal
                   ;

/* For condition of conditional statements */
statement: bool_exp
         | comp_exp
         ;

/* if statement */
if_condition: IF statement THEN code_section
            ;

/* elseif statement */
elseif_condition:
                | elseif_condition ELSEIF statement THEN code_section
                ;

/* else statement */
else_condition:
              | ELSE code_section
              ;

/* inspect statements (similar to switch in C) */
inspect_structure: INSPECT expr when_part_list ELSE code_section END
                 ;

/* multiples when part in inspect */
when_part_list:
              | when_part_list when_part
              ;

/* when part structure in Eiffel */
when_part: WHEN choices THEN code_section
         ;

/* values to when in inspect */
choices: literals
       | literals COMMA choices
       | literals DOTS literals
       ;

/* Basic loop structure in Eiffel */
loops: FROM variable_assignment variable_assignments top_loop UNTIL statement LOOP code_section bottom_loop END
     ;

/* invariant optional in loop */
top_loop:
        | invariant_contracts
        ;

/* variant optional in loop */
bottom_loop:
           | variant_contracts
           ;

/* comparison operators in Eiffel */
comp_operator: GT
             | GTEQ
             | LT
             | LTEQ
             | EQUAL
             ;

/* literal values */
literals: integer_literal
        | real_literal
        | string_literal
        | double_literal
        | character_literal
        | boolean_literal
	;

/* integer literal */
integer_literal: INTEGER
               | SUB INTEGER
               ;

/* real literal */
real_literal: REAL
            | SUB REAL
            ;

/* string literal */
string_literal: STRING
              ;

/* double literal */
double_literal: DOUBLE
              ;

/* character literal */
character_literal: CHARACTER
                 ;

/* boolean literal */
boolean_literal: BOOLEAN
               ;

/*require_contarct: REQUIRE contracts_expressions
                ;

ensure_contarct: ENSURE contracts_expressions
               ;*/

/* invariant contract for loop */
invariant_contracts: INVARIANT contracts_expressions
                   ;

/* variant construct for loop */
variant_contracts: VARIANT contracts_expressions
                 ;

/* contracts expressions */
contracts_expressions: IDENTIFIER COLON statement
                     | statement
                     | arithmetic_exp
                     ;

/* Possible expressions */
expr: bool_exp
    | arithmetic_exp
    | comp_exp
    ;

/* boolean expression starts */
bool_exp: bool_exp OR bool_term
        | bool_term
        ;

bool_term: bool_term AND bool_factor
         | bool_factor
         ;

bool_factor: bool_factor XOR bool_node
           | bool_node
           ;

bool_node: IDENTIFIER
	       | NOT bool_node
         | BOOLEAN
         | OP bool_exp CP
         ;
/* boolean expression ends */

/* Comparison expression*/
comp_exp: arithmetic_exp comp_operator arithmetic_exp
        | string_literal comp_operator string_literal
        | boolean_literal EQUAL boolean_literal
        ;

/* Arithmetic expression starts */
arithmetic_exp: arithmetic_term
              | arithmetic_exp ADD arithmetic_term
              | arithmetic_exp SUB arithmetic_term
              ;

arithmetic_term: arithmetic_factor
               | arithmetic_term MUL arithmetic_factor
               | arithmetic_term DIV arithmetic_factor
               ;

arithmetic_factor: IDENTIFIER
                 | integer_literal
                 | real_literal
                 | double_literal
                 | OP arithmetic_exp CP
                 | SUB IDENTIFIER
                 ;
/* Arithmetic expression ends */

%%

int main() {
  yyparse();
  printf("\n\t\tSyntactically Correct\n\n");
  return 0;
}

void yyerror(char* s) {
  printf("\n\t\tError: at line %d:%d, %s\n\n", yylval, col, s);
  exit(0);
}
