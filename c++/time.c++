
#include <time.h>  
#include <stdio.h>  
int main()  
{  
        time_t timep;    
        int runTime;
        time(&timep); /*当前time_t类型UTC时间*/  
        printf("time():%d\n",timep);  
        runTime=int(timep);
        if(runTime-1000>=0)
            printf("\n 1");
        else printf("\n 0");
}  
