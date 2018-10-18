%{
#include <stdio.h>
#include "scanner.h"

extern int yylex(void);
void yyerror(const char *); 
char *token_names[] = {"Fin de archivo", "Asignación","Programa","Fin","Variables","Código","Definir","Leer","Escribir", "Identificador","Constante"};
%}

%union{			/* Registro semántico */
	double num;
	char *cad;
}

%defines "parser.tab.h"
%output "parser.tab.c"
%start program /* El no terminal que es AXIOMA de la gramatica del TP2 */

%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */ 

%token FDT PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR
%token ASIGNACION "<-"
%token NEG '-'
%token <num> CONSTANTE
%token <cad> IDENTIFICADOR

%left  '-'  '+'
%left  '*'  '/'
%precedence NEG

%%
 
program : 		PROGRAMA bloquePrograma FIN;
bloquePrograma : 	variables_ code;
variables_ : 		VARIABLES | variables_ DEFINIR IDENTIFICADOR'.'{printf("definir %s\n",$3);}; 
code : 			CODIGO sentencia | code sentencia;
sentencia : 		LEER '(' listaIdentificadores')' '.' {printf("leer\n");}| ESCRIBIR '('listaExpresiones')' '.' {printf("escribir\n");}| IDENTIFICADOR "<-" expresion '.'{printf("asignacion\n");}; 
listaIdentificadores : 	IDENTIFICADOR | IDENTIFICADOR',' listaIdentificadores;
listaExpresiones : 	expresion | expresion',' listaExpresiones;
expresion : 		termino | expresion '+' termino {printf("suma\n");}| expresion '-' termino {printf("resta\n");};
termino : 		valor | termino '*' valor {printf("multiplicacion\n");}| termino '/' valor {printf("division\n");};
valor : 		IDENTIFICADOR | CONSTANTE | '-'valor {printf("inversion\n");}| '('expresion')' {printf("paréntesis\n");};

%%

