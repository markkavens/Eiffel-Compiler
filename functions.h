#include <stdio.h>
#include <string.h>
#include <stdlib.h> 

typedef struct token{
    char name[100];
    char type[20];
    int lineno;
    int colno;
    struct token *next;
}lexeme;

lexeme* symbolTable[100];  // hash array

int hash(char* a) // hash function using chaining
{
    int sum=0;
    for (int i = 0; i < strlen(a); i++)
    {
        sum+=a[i];
    }
    return sum%100;
}
int lookup(char* s)
{
    int ind = hash(s);
    if(symbolTable[ind] != NULL)
    {
        lexeme *cur = symbolTable[ind];
        while(cur!=NULL)
        {
            if(!strcmp(cur->name,s))
            {
                return 1;
            }
            cur = cur->next;
        }
    }
    return 0;
}

void insert(char* s,int line,int col,char* type)    // insert new entry in symbol table
{
    int ind = hash(s);
    if(!lookup(s))
    {
        lexeme *newToken = (lexeme*)malloc(sizeof(lexeme));
        strcpy(newToken->name,s);
        strcpy(newToken->type,type);
        newToken->lineno = line;
        newToken->colno = col;
        if(symbolTable[ind] == NULL)
        {
            
                symbolTable[ind] = newToken;
        }
        else
        {
            lexeme *cur = symbolTable[ind];
            while(cur->next!=NULL)
                cur = cur->next;

            cur->next = newToken;
        }
    }
}



// void delete()
// {
//     //lookup()

// }
void clearSymbolTable()  // free space allocated to  symbol table
{
    for (int i = 0; i < 100; i++)
    {
        if(symbolTable[i]!=NULL)
        {
            lexeme *cur = symbolTable[i];
            lexeme *prev = NULL;
            while(cur!=NULL)
            {
                prev = cur;
                cur = cur->next;
                free(prev);
            }
        }
    }
}
void printSymbolTable()  // a
{
    for (int i = 0; i < 100; i++)
    {
        
        if(symbolTable[i]!=NULL)
        {
            printf("%d\n",i);
            lexeme *cur = symbolTable[i];
            while(cur!=NULL)
            {
                printf("\nname = %s\ntype = %s\nline %d\tcol %d\n",cur->name,cur->type,cur->lineno,cur->colno);
                cur = cur->next;
            }
            printf("\n");
        }
        
    }
}
