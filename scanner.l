%top{
	#include <stdio.h>
	#include "parser.tab.h"
	int errlex;
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option noyywrap
%option yylineno

Letra  							[[:alpha:]]
Digito  						[0-9]
LetraDigito 						[[:alnum:]]
Espacio  						[[:space:]]
OperadorAsignacion 					<-
Comentario						"//".*
Otros  							[[:punct:]]{-}[().,+\-*/]

%%
programa						return PROGRAMA;
fin							return FIN;
variables						return VARIABLES;
codigo							return CODIGO;
definir							return DEFINIR;
leer							return LEER;
escribir 						return ESCRIBIR;
{Letra}{LetraDigito}*					{yylval.cad = strdup(yytext);return IDENTIFICADOR;}
{Digito}+						{yylval.num = atoi(yytext);return CONSTANTE;}
"("							return '(';
")"							return ')';
"."							return '.';
","							return ',';
"+"							return '+';
"-"							return '-';
"*"							return '*';
"/"							return '/';
{OperadorAsignacion}					return ASIGNACION;
{Otros}+						{printf("linea #%d: Error léxico: cadena desconocida %s\n",yylineno,yytext);errlex++;}
{Letra}{LetraDigito}*{Otros}+({LetraDigito}|{Otros})*	{printf("linea #%d: Error léxico: identificador inválido: %s\n",yylineno,yytext);errlex++;}
{Digito}+{Letra}+{LetraDigito}*				{printf("linea #%d: Error léxico: constante inválida: %s\n",yylineno,yytext);errlex++;}
{Espacio}+						|
{Comentario}						|
.																													;
%%
