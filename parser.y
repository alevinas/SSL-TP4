%{
#include <stdio.h>
#include "scanner.h"

extern int yylex(void);
void yyerror(const char *); 


char *token_names[] = {"Fin de archivo", "Asignación","Programa","Fin","Variables","Código","Definir","Leer","Escribir", "Identificador","Constante"};
%}

%union{
	double num;
	char *cad;
}

%defines "parser.tab.h"
%output "parser.tab.c"
%start program /* El no terminal que es AXIOMA de la gramatica del TP2 */



%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */ 

%token FDT PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR
%token ASIGNACION "<-"
%token <num> CONSTANTE
%token <cad> IDENTIFICADOR

%%
 
program : 		PROGRAMA bloquePrograma FIN;
bloquePrograma : 	variables_ code;
variables_ : 		VARIABLES | variables_ DEFINIR IDENTIFICADOR'.'{printf("definir: %s \n",$3);};
code : 			CODIGO sentencia | code sentencia;
sentencia : 		LEER '(' listaIdentificadores')' '.' | ESCRIBIR '('listaExpresiones')' '.' | IDENTIFICADOR "<-" expresion '.'; 
listaIdentificadores : 	IDENTIFICADOR | IDENTIFICADOR',' listaIdentificadores;
listaExpresiones : 	expresion | expresion',' listaExpresiones;
expresion : 		termino | expresion '+' termino | expresion '-' termino;
termino : 		valor | termino '*' valor | termino '/' valor;
valor : 		IDENTIFICADOR | CONSTANTE | '-'valor | '('expresion')'

%%


int main() {
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}
/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	puts(s);
	return;
}
