
using namespace std;

void EvenFibonacciNumbers()
{
  int tot=2;
  
  int term1=1;
  int term2=2;
  
  int next=3;

  while(next<4000000)
    {
      next=term1+term2;
      if(next%2==0)
	tot=tot+next;
      term1=term2;
      term2=next;
    }
  cout<<tot<<'\n';
}
