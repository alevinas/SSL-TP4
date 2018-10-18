#include <stdio.h>
#include "parser.tab.h"
#include "scanner.h"

int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilacion terminada con exito"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	printf("Compilación terminada con éxito\n");
	// Errors sintácticos: 0 - Errores léxicos: 0
	//printf("Errores sintácticos:\t\t%d - Errores léxicos:\t\t$%d",yynerrs,errlex);
	return 0;
}



/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	puts(s);
	return;
}

