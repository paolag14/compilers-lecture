%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER CAPABILITIES

%%

chatbot : greeting
        | farewell
        | query
        | name
        | weather
        | capabilities
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

name : NAME { printf("Chatbot: My name is Chatbot! Nice to meet you.\n"); }
     ;

weather : WEATHER { printf("Chatbot: The weather in Guadalajara, Jalisco, Mexico is usually warm and sunny.\n"); }
        ;

capabilities : CAPABILITIES { printf("Chatbot: I'm a Chatbot, you can greet me, say goodbye, ask me the time or ask me about the weather.\n"); }
             ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
