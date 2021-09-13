%{
#include <math.h>
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

%right OP_ASSIGN
%left OP_SUM OP_SUB
%left OP_MULT OP_DIV

%token INT_CONSTANT ID

%token OP_SUM OP_SUB OP_MULT OP_DIV

%token PARENTHESIS_OPEN PARENTHESIS_CLOSE

%token OP_ASSIGN

%token SEMICOLON

%token START_RESERVED_WORD END_RESERVED_WORD

%%
program: START_RESERVED_WORD code END_RESERVED_WORD;

code: code line | line;

line: expression SEMICOLON;

expression: ID OP_ASSIGN expression
          | expression OP_SUM term
          | expression OP_SUB term
          | expression OP_MULT term
          | expression OP_DIV term
          | PARENTHESIS_OPEN expression PARENTHESIS_CLOSE
          | term;

term: ID | INT_CONSTANT;
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