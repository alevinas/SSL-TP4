//////////////////////////////////////////////////////////////////////////////////////
/*
      TP4 - 2018
      "Compilador"
      Grupo 03

     Ordóñez Julián Mateo
      1602974
     Torres Schulten Manuel
      160.688.8
     Viegas Manuel
      150.205.0
     Viñas Alejandro Fabian
      160.613-0
                                                                                    */
//////////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include "parser.tab.h"
#include "scanner.h"

int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilacion terminada con exito"); return 0;
	case 1:
		puts("Errores de compilación");	/*printf("Errores sintácticos: - Errores léxicos: %d\n",yynerrs,errlex);*/ return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	//Errors sintácticos: 0 - Errores léxicos: 0
	return 0;
}



/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d  %s\n", yylineno, s);
	return;
}

