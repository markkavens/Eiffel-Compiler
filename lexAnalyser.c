#include<stdio.h>
#include<string.h>
#include <stdlib.h> 

struct token{
    char name[20];
    char type[20];
    struct token *next;
};

struct token* hashArr[100];

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
    struct token *newToken = (struct token*)malloc(sizeof(struct token));
    if(hashArr[ind] == NULL)
    {
        hashArr[ind] = newToken;
    }
    else
    {
        struct token *cur = hashArr[ind];
        while(cur->next!=NULL)
            cur = cur->next;

        cur->next = newToken;
    }
}
void lookup()
{

}
void clearSymbolTable()  // free space allocated to  symbol table
{
    for (int i = 0; i < 100; i++)
    {

        
    }
    

}

int main(int argv,char* argc)
{
    

    return 0;
}

