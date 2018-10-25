%top{
	#include <stdio.h>
	#include "parser.h"
	int errlex;
	char bufferNuevo[200];
	void yyerror(const char *);
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
{Letra}{LetraDigito}*					{yylval = strdup(yytext);return IDENTIFICADOR;}
{Digito}+						{yylval = strdup(yytext);return CONSTANTE;}
"("							return '(';
")"							return ')';
"."							return '.';
","							return ',';
"+"							return '+';
"-"							return '-';
"*"							return '*';
"/"							return '/';
{OperadorAsignacion}					return ASIGNACION;
{Otros}+						{sprintf(bufferNuevo, "Error léxico: cadena desconocida: %s", yytext);yyerror(bufferNuevo);errlex++;}
{Letra}{LetraDigito}*{Otros}+({LetraDigito}|{Otros})*	{sprintf(bufferNuevo, "Error léxico: identificador inválido: %s",yytext);yyerror(bufferNuevo);errlex++;}
{Digito}+{Letra}+{LetraDigito}*				{sprintf(bufferNuevo, "Error léxico: constante inválida: %s",yytext);yyerror(bufferNuevo);errlex++;}
{Espacio}+						|
{Comentario}						|
.																													;
%%
