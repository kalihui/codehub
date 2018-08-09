#include<stdio.h>
#include<math.h>


int main()
{
    float bf,pror,ppv;

    //从终端输入bf和pror值
    printf("input the value of BF:\n");
    scanf("%f",&bf);
    printf("input the value of pror:\n");
    scanf("%f",&pror);


    ppv = calculate(bf,pror);
    printf("The value of ppv is %f\n",ppv);
    return 0;

}

float calculate(float bf,float pror)
{
    float poor=bf*pror,ppv=poor/(poor+1);

    return ppv;
}








}