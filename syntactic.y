%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

#define COLOR_RED "\033[1;31m"
#define COLOR_RESET "\033[0m"

int lineno;

int yylval;
int yystopparser = 0;

FILE *yyin;

char *yyltext;
char *yytext;

int yylex();
int yyerror(char *);
%}

%left OP_SUM OP_SUB
%left OP_MULT OP_DIV

%token INT_CONSTANT
%token ID
%token OP_SUM
%token OP_SUB
%token OP_MULT
%token OP_DIV

%%
expression: ID OP_SUM ID
          | ID OP_SUB ID
          | ID OP_MULT ID
          | ID OP_DIV ID
          | ID;
%%

int main(int argc,char *argv[]) {
  const char* filename = argv[1];
  FILE* arg_file = fopen(filename, "rt");

  if (arg_file == NULL ) {
    printf("File cannot be opened: %s\n", filename);
    printf("Using standard input\n\n");
  }
  else {
    yyin = arg_file;
  }

  yyparse();

  fclose(yyin);

  return EXIT_SUCCESS;
}

int yyerror(char *error) {
  fprintf(stderr, COLOR_RED "\nline %d: %s\n" COLOR_RESET, lineno, error);
  fclose(yyin);
  exit(1);
}