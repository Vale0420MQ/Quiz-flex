%{
#include <stdio.h>
%}

/* Definiciones */
DIGITOS     [0-9]+
REAL        -?{DIGITOS}("."{DIGITOS})?
IMAGINARIA  [iIjJ]

%%

{REAL}"+"{REAL}{IMAGINARIA}   { printf("ACEPTA: %s\n", yytext); }
{REAL}"-"{REAL}{IMAGINARIA}   { printf("ACEPTA: %s\n", yytext); }

[^ \t\n]+   { printf("NO ACEPTA: %s\n", yytext); }
[ \t\n]     { /* Ignorar espacios y saltos de linea */ }

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_entrada.txt>\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        fprintf(stderr, "Error: No se pudo abrir el archivo '%s'\n", argv[1]);
        return 1;
    }

    yyin = archivo;
    yylex();
    fclose(archivo);
    return 0;
}

int yywrap() {
    return 1;
}
