import java_cup.runtime.*;
%%
%implements java_cup.runtime.Scanner
%type Symbol
%function next_token
%state COMMENT
%class A4Scanner
%eofval{
    return null;
%eofval}

IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]*
DIGIT      = [0-9]
LETTER     = [a-zA-Z]
NUMBER     = {DIGIT}+(\.{DIGIT}+)?
TYPE       = STRING|INT|REAL

%% 

<COMMENT>.|\n|\r               { /* ignore */ }

<YYINITIAL>{NUMBER}            { 
    return new Symbol(A4Symbol.NUMBER, Integer.parseInt(yytext())); 
}

<YYINITIAL>"\""[^\"\n]*"\""    { 
    return new Symbol(A4Symbol.QUOTED, yytext()); 
}

<YYINITIAL>"'"[^'\n]*"'"       { 
    return new Symbol(A4Symbol.QUOTED, yytext()); 
}

<YYINITIAL>[ \t\r\n]+          { /* ignore whitespace */ }

<YYINITIAL>"WRITE"             { return new Symbol(A4Symbol.WRITE); }
<YYINITIAL>"READ"              { return new Symbol(A4Symbol.READ); }
<YYINITIAL>"IF"                { return new Symbol(A4Symbol.IF); }
<YYINITIAL>"ELSE"              { return new Symbol(A4Symbol.ELSE); }
<YYINITIAL>"RETURN"            { return new Symbol(A4Symbol.RETURN); }
<YYINITIAL>"BEGIN"             { return new Symbol(A4Symbol.BEGIN); }
<YYINITIAL>"END"               { return new Symbol(A4Symbol.END); }
<YYINITIAL>"MAIN"              { return new Symbol(A4Symbol.MAIN); }
<YYINITIAL>"STRING"            { return new Symbol(A4Symbol.TYPE, yytext()); }
<YYINITIAL>"INT"               { return new Symbol(A4Symbol.TYPE, yytext()); }
<YYINITIAL>"REAL"              { return new Symbol(A4Symbol.TYPE, yytext()); }
<YYINITIAL>"TRUE"              { return new Symbol(A4Symbol.TRUE); }
<YYINITIAL>"FALSE"             { return new Symbol(A4Symbol.FALSE); }

<YYINITIAL>{IDENTIFIER}        { 
    return new Symbol(A4Symbol.ID, yytext()); 
}

<YYINITIAL>";"                 { return new Symbol(A4Symbol.SEMICOLON); }
<YYINITIAL>","                 { return new Symbol(A4Symbol.COMMA); }
<YYINITIAL>"("                 { return new Symbol(A4Symbol.LPAREN); }
<YYINITIAL>")"                 { return new Symbol(A4Symbol.RPAREN); }

<YYINITIAL>"+"                 { return new Symbol(A4Symbol.ADD, yytext()); }
<YYINITIAL>"-"                 { return new Symbol(A4Symbol.ADD, yytext()); }
<YYINITIAL>"*"                 { return new Symbol(A4Symbol.MULTIPLY, yytext()); }
<YYINITIAL>"/"                 { return new Symbol(A4Symbol.MULTIPLY, yytext()); }

<YYINITIAL>"=="                { return new Symbol(A4Symbol.EQ); }
<YYINITIAL>"!="                { return new Symbol(A4Symbol.NOTEQ); }
<YYINITIAL>"="                 { return new Symbol(A4Symbol.ASSIGN); }

<YYINITIAL>"/**"               { yybegin(COMMENT); }
<COMMENT>"**/"                 { yybegin(YYINITIAL); }

/* Error handling: catch any invalid character */
<YYINITIAL>.                   { 
    return new Symbol(A4Symbol.ERROR, yytext()); 
}
