// atoi可以把字符串转化为整形，其方法为把小数部分舍去




#include<stdlib.h>
#include<stdio.h>
int main()
{
    char *str1="0.1";
    char *str2="0.6";
    char *str3="1.2";
    char *str4="-0.2";
    char *str5="-0.99";
    char *str6="-1.2";
    printf("str1:%d\nstr2:%d\nstr3:%d\nstr4:%d\nstr5:%d\nstr6:%d\n",atoi(str1),atoi(str2),atoi(str3),atoi(str4),atoi(str5),atoi(str6));
    return 0;
}
