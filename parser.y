%code top{
#include <stdio.h>
%}

%defines "parser.h"
%output "parser.c"
%start program /* El no terminal de la gramatica del TP2 */
%define api.value.type {char *} /* Registro semantico */ 

%%
 
program : "programa" bloquePrograma "fin" ;
bloquePrograma : variables' code;
variables' : "variables" | variables' "definir" identificador'.';
code : "codigo" sentencia | code sentencia
sentencia : "leer" '('listaIdentificadores")." | "escribir" '('listaExpresiones")." | identificador "<-" expresion; 
listaIdentificadores : identificador | identificador',' listaIdentificadores;
listaExpresiones


%%

