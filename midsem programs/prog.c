#include<stdio.h>
void main(){
	int *p = NULL;
	p = malloc(sizeof(int)*1);
	*p = 3;
	printf("Value : %d", *p);
	free(p);
	printf("Again : %d", *p);
}