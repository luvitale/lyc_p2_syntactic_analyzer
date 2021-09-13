%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

FILE *yyin;

int yylval;
int lineno = 1;

int yyerror(char *);
%}

%option noyywrap
%option yylineno

natural_digit [1-9]
digit (0|{natural_digit})
uppercase_letter [A-Z]
lowercase_letter [a-z]
letter ({uppercase_letter}|{lowercase_letter})

int_constant ({digit}|{natural_digit}{digit}*)
op_sum "+"
op_sub "-"
op_mult "*"
op_div "/"
id {letter}(_?({letter}|{digit}))*

parenthesis_open "("
parenthesis_close ")"

op_assign ":="

semicolon ";"

%%
{op_sum} {
  printf("OP_SUM/%s\n", yytext);
  return OP_SUM;
}
{op_sub} {
  printf("OP_SUB/%s\n", yytext);
  return OP_SUB;
}
{op_mult} {
  printf("OP_MULT/%s\n", yytext);
  return OP_MULT;
}
{op_div} {
  printf("OP_DIV/%s\n", yytext);
  return OP_DIV;
}
{int_constant} {
  int num = atoi(yytext);
  printf("INT_CONSTANT/%d\n", num);
  yylval = num;
  return INT_CONSTANT;
}
{id} {
  printf("ID/%s\n", yytext);
  return ID;
}

{parenthesis_open} {
  printf("PARENTHESIS_OPEN/%s\n", yytext);
  return PARENTHESIS_OPEN;
}
{parenthesis_close} {
  printf("PARENTHESIS_CLOSE/%s\n", yytext);
  return PARENTHESIS_CLOSE;
}

{op_assign} {
  printf("OP_ASSIGN/%s\n", yytext);
  return OP_ASSIGN;
}

{semicolon} {
  printf("SEMICOLON/%s\n", yytext);
  return SEMICOLON;
}

" "
"\n" {
  ++lineno;
}
"\t"

. {
  char s[] = "invalid character: ";

  strcat(s, yytext);
  strcat(s, "\n");

  yyerror(s);
}
%%