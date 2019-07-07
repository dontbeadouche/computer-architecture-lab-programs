#include <stdio.h>

typedef enum op { ADD, SUB, MUL, DIV, MOD} OPS;

/*function defnitions*/
int add(int a, int b) { return a+b;}
int sub(int a, int b) { return a-b;}
int mul(int a, int b) { return a*b;}
int div(int a, int b) { return a/b;}
int mod(int a, int b) { return a%b;}

/*array of function pointers*/
int (*fptr[])(int, int) = { add, sub, mul, div, mod}; 

/*array of strings*/
char *op_str[] = {"PLUS", "MINUS", "MUL", "DIV", "MOD"};

int do_op(OPS op, int a, int b)
{
  int c;
  c = fptr[op](a, b);
  return c;
}

main()
{

  int x = 10, y = 6, z;

  z = do_op(ADD, x, y);
  printf("%d %s %d = %d\n", x, op_str[ADD], y, z);

  z = do_op(SUB, x, y);
  printf("%d %s %d = %d\n", x, op_str[SUB], y, z);
  
  z = do_op(MUL, x, y);
  printf("%d %s %d = %d\n", x, op_str[MUL], y, z);

  z = do_op(DIV, x, y);
  printf("%d %s %d = %d\n", x, op_str[DIV], y, z);

  z = do_op(MOD, x, y);
  printf("%d %s %d = %d\n", x, op_str[MOD], y, z);

}
