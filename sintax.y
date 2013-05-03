%{
#include <stdio.h>
#include <string.h>

extern int yylex();

FILE* fileOut;
extern FILE* yyin;

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
}

void prtlistaexp(char* s);
void prtexp (char *s);

%}

%union {
        long int4;              /* Constant integer value */
        float fp;               /* Constant floating point value */
        char str[50];           /* Ptr to constant string (strings are malloc'd) */
    };

%type <str> IDTOK

%type <fp> REALTOK

%type <int4> INTEIROTOK

%type <str> STRINGTOK CARACTERTOK bind identificador exp listaexp

%token HEADTOK TAILTOK MAPTOK TWICETOK IFTOK THENTOK ELSETOK IDTOK INTEIROTOK REALTOK PLUSTOK MINUSTOK MULTTOK DIVTOK PAR1TOK PAR2TOK EQTOK CONSTOK DECLTOK ARROWTOK TPSTRINGTOK TPINTTOK TPFLOATTOK TPBOOLTOK TPCHARTOK CARACTERTOK CMPEQTOK CMPNEQTOK CMPLTTOK CMPGTTOK ORTOK CMPLTETOK CMPGTETOK ANDTOK NOTTOK STRINGTOK COLCH1TOK COLCH2TOK LISTAVAZIATOK DONTCARETOK TRUETOK FALSETOK MAINTOK

%left '|'
%left '&'
%left CMPEQTOK CMPNEQTOK ORTOK ANDTOK
%left TOKNOTTOK
%left CMPLTTOK CMPGTTOK CMPLTETOK CMPGTETOK
%left PLUSTOK MINUSTOK
%left MULTTOK DIVTOK
%left CONSTOK

%start bind

%%


bind:	MAINTOK {printf("(\\main.main");} listaargs {printf(")");} EQTOK exp
		|
		identificador {printf("(\\main.main");} listaargs EQTOK exp

identificador: IDTOK

listaargs:	INTEIROTOK {printf("(%ld)",$1);}
		|
		STRINGTOK {printf("(%s)",$1);}
		|
		CARACTERTOK {printf("(%s)",$1);}
		|
		REALTOK {printf("(%f)",$1);}
		|
		FALSETOK {printf("(false)");}
		|
		TRUETOK {printf("true");}
		|
		identificador {printf("(%s)",$1);}
        |
        PLUSTOK {printf("+");} exp exp
        |
        MINUSTOK {printf("-");} exp exp
        |
                MULTTOK {printf("*");} exp exp
                |
                DIVTOK {printf("-");} exp exp 
                |
                CMPEQTOK {printf("==");} exp exp
                |
                CMPNEQTOK {printf("!=");}exp exp
                |
                CMPLTTOK {printf("<");}exp exp
                |
                CMPGTTOK {printf(">");} exp exp
                |
                CMPLTETOK {printf("<=");} exp exp
                |
                CMPGTETOK {printf(">=");} exp exp
                |
                ANDTOK {printf("&");} exp exp
                |
                ORTOK {printf("|");} exp exp
		|
		CONSTOK {printf("-");} exp exp {printf(":");}
		|
		NOTTOK {printf("-");} exp {printf("!");}
		

tipo: 		tipodec
		|
		tipodec ARROWTOK tipo

literal: INTEIROTOK | REALTOK | CARACTERTOK | STRINGTOK | FALSETOK | TRUETOK

chamada: 	nativasf
			|
			identificador listaexp {printf("(%s)",$1);}
			
nativasf: 	HEADTOK exp {printf("head");}
		|
		TAILTOK exp{printf("head");}
		| 
		MAPTOK identificador exp {printf("map(%s)",$2);}
		|
		TWICETOK chamada {printf("twice");}

listaexp:	exp listaexp {prtlistaexp($2);}
			|;

exp:    PAR1TOK {printf("(");} exp PAR2TOK{printf(")");}
		|
		INTEIROTOK {printf("(%ld)",$1);}
		|
		STRINGTOK {printf("(%s)",$1);}
		|
		CARACTERTOK {printf("(%s)",$1);}
		|
		REALTOK {printf("(%f)",$1);}
		|
		FALSETOK {printf("(false)");}
		|
		TRUETOK {printf("true");}
		|
		identificador {printf("(%s)",$1);}
        |
        PLUSTOK {printf("+");} exp exp
        |
        MINUSTOK {printf("-");} exp exp
        |
                MULTTOK {printf("*");} exp exp
                |
                DIVTOK {printf("-");} exp exp 
                |
                CMPEQTOK {printf("==");} exp exp
                |
                CMPNEQTOK {printf("!=");}exp exp
                |
                CMPLTTOK {printf("<");}exp exp
                |
                CMPGTTOK {printf(">");} exp exp
                |
                CMPLTETOK {printf("<=");} exp exp
                |
                CMPGTETOK {printf(">=");} exp exp
                |
                ANDTOK {printf("&");} exp exp
                |
                ORTOK {printf("|");} exp exp
		|
		CONSTOK {printf("-");} exp exp {printf(":");}
		|
		NOTTOK {printf("-");} exp {printf("!");}
		|
		chamada
%%


void prtexp(char *s)
{
	printf("%s",s);
}
void prtlistaexp(char *s)
{
	printf("%s",s);
}

main(int argc, char **argv )
{
		printf("\n\n\n================     INICIO DE COMPILACAO.   ================\n\n\n");
		
		if( argc > 1 )
		{
			yyin = fopen( argv[2], "r" );
		}
		else
		{
			yyin = stdin;
		}
		
		fileOut = stdout;//fopen ("parsed.txt", "w");
				printf ("\n************  INICIO DO FRONTEND   ************\n\n\n");
				yyparse(); 
				printf ("\n************  FIM DO FRONTEND   ************\n\n\n");

		fclose(fileOut);
		
		//backEnd();
	
		printf("\n\n\n================     FIM DE COMPILACAO. SUCESSO.    ================\n\n\n");
		
}

