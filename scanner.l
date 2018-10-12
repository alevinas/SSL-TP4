%top{
	#include <stdio.h>
	#include "tokens.h"
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput


Letra  							[[:alpha:]]
Digito  						[0-9]
LetraDigito 						[[:alnum:]]
Espacio  						[[:space:]]
CaracterPuntuacion 					[\(\)\.\,]
Operador 						[+|/|*|-]
OperadorAsignacion 					"<-"
Comentario						"//".*
Otros  							[[:punct:]]{-}["("")""."",""+""-""*""/"]

%%
programa						return PROGRAMA;
fin							return FIN;
variables						return VARIABLES;
codigo							return CODIGO;
definir							return DEFINIR;
leer							return LEER;
escribir 						return ESCRIBIR;
{Letra}{LetraDigito}*					return IDENTIFICADOR;
{Digito}+						return CONSTANTE;
"("							return '(';
")"							return ')';
"."							return '.';
","							return ',';
"+"							return '+';
"-"							return '-';
"*"							return '*';
"/"							return '/';
{OperadorAsignacion}					return ASIGNACION;
{Otros}+						printf("Error léxico: cadena desconocida: %s\n",yytext);
{Letra}{LetraDigito}*{Otros}+({LetraDigito}|{Otros})*	printf("Error léxico: identificador inválido: %s\n",yytext);
{Digito}+{Letra}+{LetraDigito}*				printf("Error léxico: constante inválida: %s\n",yytext);
{Espacio}+						|
{Comentario}						|
.																													;
%%
