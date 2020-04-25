#include <string.h>
#include <stdlib.h>
#include "uthash.h" 

typedef struct {
    int line_no;
    int col_no;
    char *type;
} Content;

typedef struct token{
    char *val;      /* Key */
    Content* content;
    UT_hash_handle hh;
} Lexeme;

Lexeme* lexemes = NULL;  /* hash array */

void addHash(char* type, int line_no, char* value, int col_no) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    // temp->val = value;
    strcpy(temp->val, value);
    temp->content = (Content*)malloc(sizeof(Content));
    temp->content->line_no = line_no;
    temp->content->col_no = col_no;
    temp->content->type = type;
    HASH_ADD_KEYPTR(hh, lexemes, temp->val, strlen(temp->val), temp);
    free(temp);
}

Lexeme* findHash(char* str) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    HASH_FIND_STR(lexemes, str, temp);
    return temp;
}


void addHashUtil(char* yytext, char* type, int line, int col) {
    Lexeme* temp = (Lexeme*)malloc(sizeof(Lexeme));
    temp = findHash(yytext);
    if(temp == NULL)
        addHash(type, line, yytext, col);
}