#include <string.h>
#include <stdlib.h> 

typedef struct token{
    char name[100];
    char type[20];
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

void insert(char* s)    // insert new entry in symbol table
{
    int ind = hash(s);
    lexeme *newToken = (lexeme*)malloc(sizeof(lexeme));
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
int lookup(char* s)
{
    int ind = hash(s);
    if(symbolTable[ind] != NULL)
    {
        lexeme *cur = symbolTable[ind];
        while(cur->next!=NULL)
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

void delete()
{
    //lookup()

}
void clearSymbolTable()  // free space allocated to  symbol table
{
    // for (int i = 0; i < 100; i++)
    // {
    //     if(symbolTable[i]!=NULL)
    //     {
    //         lexeme *cur = symbolTable[i];
    //         while(cur->next!=NULL)
    //             cur = cur->next;
    //     }

        
    // }
    

}
