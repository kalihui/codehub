#include<iomanip>
#include<iostream>
using namespace std;
int main()
{
    cout<<"0123456789012345678901234567890123456789\n";
    cout<<"hello"<<setw(0)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"hello"<<"\t"<<setw(0)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"hello"<<"\t"<<setw(1)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"hello"<<"\t"<<setw(8)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"h"<<setw(2)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"h"<<setw(8)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    cout<<"hellohello"<<"\t"<<setw(1)<<"w"<<"or"<<"l"<<"d"<<"!"<<"\n";
    
    cout<<"Compare with \\t\n";
    
    cout<<"hellohello"<<setw(8)<<"world\n";
    cout<<"hellohello"<<"\t"<<setw(8)<<"world\n";
    cout<<"hello"<<setw(8)<<"world\n";
    cout<<"hello"<<"\t"<<setw(8)<<"world\n";



}
