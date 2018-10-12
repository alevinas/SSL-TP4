%code top{
#include <stdio.h>
#include "scanner.h"
%}

%code provides{
void yyerror(const char *); 
int yyparse(void);
extern int yylexerrs;
}

%defines "parser.tab.h"
%output "parser.tab.c"
%start program /* El no terminal que es AXIOMA de la gramatica del TP2 */
%define api.value.type {char *} /* Registro semantico (PROBABLEMENTE STRUCT O UNION?) */
%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */ 

%token FDT,PROGRAMA,FIN,VARIABLES,CODIGO,DEFINIR,LEER,ESCRIBIR,IDENTIFICADOR,CONSTANTE
%token ASIGNACION "<-"

%%
 
program : PROGRAMA bloquePrograma FIN ;
bloquePrograma : variables' code;
variables' : VARIABLES | variables' DEFINIR identificador.;
code : CODIGO sentencia | code sentencia
sentencia : LEER '('listaIdentificadores')''.' | ESCRIBIR (listaExpresiones')''.' | identificador "<-" expresion; 
listaIdentificadores : identificador | identificador',' listaIdentificadores;
listaExpresiones : expresion | expresion',' listaExpresiones;
expresion : termino | expresion '+' {printf("Token: %s\t\t  termino | expresion '-' termino;
termino : valor | termino '*' valor | termino '/' valor;
valor : identificador | constante | '-'valor | '('expresion')'


%%

