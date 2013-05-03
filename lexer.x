//atualizando linha 1 - v4

/atualizando linha 3 - v2

%{
#include <stdio.h>
#include "sintax.tab.h"

extern YYSTYPE yylval;

%}

%%
head				return HEADTOK;
tail				return TAILTOK;
map				return MAPTOK;
twice				return TWICETOK;
main				return MAINTOK;
if				return IFTOK;
then				return THENTOK;
else				return ELSETOK;
false				return FALSETOK;
true				return TRUETOK;
[a-z][a-zA-Z0-9]*    		strcpy(yylval.str,yytext); 	return IDTOK;
[0-9]+				yylval.int4=atoi(yytext);		return INTEIROTOK;
[0-9]+\.[0-9]+			yylval.fp=atof(yytext);			return REALTOK;
\+				return PLUSTOK;
\-				return MINUSTOK;
\*				return MULTTOK;
\/				return DIVTOK;
\(				return PAR1TOK;
\)				return PAR2TOK;
\=				return EQTOK;
:				return CONSTOK;
::				return DECLTOK;
\-\>				return ARROWTOK;
String				return TPSTRINGTOK;
Int				return TPINTTOK;
Float				return TPFLOATTOK;
Bool				return TPBOOLTOK;
Char				return TPCHARTOK;
\[				return COLCH1TOK;
\]				return COLCH2TOK;
\[\]				return LISTAVAZIATOK;
\'[$printable $special]\'	strcpy(yylval.str,yytext);	return CARACTERTOK;
\=\=				return CMPEQTOK;
\/\=				return CMPNEQTOK;
\<				return CMPLTTOK;
\>				return CMPGTTOK;
\|\|				return ORTOK;
\<\=				return CMPLTETOK;
\>\=				return CMPGTETOK;
\&\&				return ANDTOK;
\!				return NOTTOK;
\_				return DONTCARETOK;
\"[$printable $special]*\"      strcpy(yylval.str,yytext);	return STRINGTOK;
\n                      	/* ignore EOL */;
[ \t]+                  	/* ignore whitespace */;
%%

