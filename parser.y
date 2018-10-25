%{
#include <stdio.h>
#include "scanner.h"
%}

%code provides {
extern int errlex; 	/* Contador de Errores Léxicos */

}

%define api.value.type{char *}


%defines "parser.h"
%output "parser.c"
%start program /* El no terminal que es AXIOMA de la gramatica del TP2 */
%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */

%token PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR CONSTANTE IDENTIFICADOR
%token ASIGNACION "<-"

%left  '-'  '+'
%left  '*'  '/'
%precedence NEG

%%

program : 		  				PROGRAMA bloquePrograma FIN {if (errlex+yynerrs > 0) YYABORT;else YYACCEPT;};

bloquePrograma : 	  		variables_ code;

variables_ : 		  			VARIABLES
                        | variables_ DEFINIR IDENTIFICADOR'.'{printf("definir %s\n",$3);}
												| variables_ DEFINIR error'.';

code : 			  					CODIGO sentencia
                        | code sentencia;

sentencia : 		  			LEER '(' listaIdentificadores')' '.' 	{printf("leer\n");}
                        | ESCRIBIR '('listaExpresiones')' '.' {printf("escribir\n");}
                        | IDENTIFICADOR "<-" expresion '.'		{printf("asignacion\n");}
												| error'.';

listaIdentificadores : 	IDENTIFICADOR
                        | IDENTIFICADOR',' listaIdentificadores;

listaExpresiones : 	  	expresion
                        | expresion',' listaExpresiones;

expresion : 		  			valor
                        | '-'valor %prec NEG								{printf("inversion\n");}
                        | '('expresion')' 				{printf("paréntesis\n");}
                        | expresion '+' expresion {printf("suma\n");}
                        | expresion '-' expresion {printf("resta\n");}
                        | expresion '*' expresion {printf("multiplicacion\n");}
                        | expresion '/' expresion {printf("division\n");}
												| '(' error ')';

valor : 		  					IDENTIFICADOR
                        | CONSTANTE;

%%

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
        printf("línea #%d  %s\n", yylineno, s);
        return;
}
