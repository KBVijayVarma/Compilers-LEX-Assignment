
%{
#include<stdio.h>
#include<string.h>
char a[8][8];
void print_board()
{
	printf(" \t");
	for(int i=0;i<7;i++)
	{
		printf("%c\t",i+97);
	}
	printf("%c\n\n",104);
    for(int i=0;i<8;i++)
    {
	printf("%d\t",i+1);
	    for(int j=0;j<8;j++)
	    {
	        if(a[i][j] != 'Z')
		{
			if(j == 7)
				printf("%c\n\n",a[i][j]);
			else
	        		printf("%c\t",a[i][j]);
		}
	        else
		{
			if(j == 7)
				printf(" \n\n");
	        	else
				printf(" \t");
		}
	    }
    }
}

void update(char s[], int count)
{
    if(count == 1)
    {
        char first = s[0];
        char second = s[1];
        char third = s[2];
        char fourth = s[3];
        char fifth = s[4];
        char sixth = s[5];
        a[(int)(third)-49][(int)(second) - 97] = 'Z';
        a[(int)(sixth)-49][(int)(fifth) - 97] = first;
    }
    else if(count == 0)
    {
        char first = s[0];
        char second = s[1];
        char third = s[2];
        char fourth = s[3];
        char fifth = s[4];
        a[(int)(second)-49][(int)(first) - 97] = 'Z';
        a[(int)(fifth)-49][(int)(fourth) - 97] = 'P';
    }
    else
    {
        char first = s[0];
        char second = s[1];
        char third = s[2];
        char fourth = s[3];
        char fifth = s[4];
        char sixth = s[5];
        char seventh = s[6];
        a[(int)(second)-49][(int)(first) - 97] = 'Z';
        a[(int)(fifth)-49][(int)(fourth) - 97] = seventh;
    }

}

%}


%%

([R|N|B|K|Q|P]?[a-h][1-8][-|x][a-h][1-8]) {update(yytext,yyleng-5);}

([a-h][1-8][-|x][a-h][1-8]=[R|N|B|Q]) {update(yytext,yyleng-5);}

(" ") {;}
("\n") {;}


%%

int yywrap(void){}






void initialise()
{
    for(int i=0;i<8;i++)
    {
	    for(int j=0;j<8;j++)
	    {
		    if(i==1 || i == 6)
			    a[i][j] = 'P';
		    else if(i == 0 || i == 7)
		    {
			    if(j==0 || j==7)
				    a[i][j] = 'R';
			    else if(j==1||j==6)
				    a[i][j] = 'N';
			    else if(j==2||j==5)
				    a[i][j] = 'B';
			    else if(j==3)
				    a[i][j] = 'Q';
			    else
				    a[i][j] = 'K';
		    }
		    else
			    a[i][j] = 'Z';
	    }
    }
}



int main()
{
	initialise();
	yylex();
	print_board();
	return 0;
}

