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
#include "parser.h"
#include "scanner.h"
extern int yynerrs;

int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilacion terminada con exito"); printf("Errores sintácticos: %d - Errores léxicos: %d\n",yynerrs,errlex); return 0;
	case 1:
		puts("Errores de compilación");	printf("Errores sintácticos: %d - Errores léxicos: %d\n",yynerrs,errlex); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}




