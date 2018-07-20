
using namespace std;


void MultiplesOf3And5()
{
  int tot=0;
  for(int i=0;i<1000;i++)
    {
      if(i%3==0||i%5==0)
	{
	  tot=tot+i;
	}
    }
  cout<<tot<<'\n';
}
