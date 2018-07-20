
using namespace std;

void SummationOfPrimes()
{
  const int high=2000000;
  bool pos[high];
  
  for(int n=0;n<high;n++)
    {
      pos[n]=true;
    }
  for(int k=2;k<high;k++)
    if(pos[k]==true)
      for(int f=k+k;f<high;f=f+k)
	pos[f]=false;
    
  long int tot=0;
  for(int i=2;i<high;i++)
    {
      if(pos[i]==true)
	{
	  tot=tot+i;
	  //cout<<"i="<<i<<'\n';
	  //cout<<"tot="<<tot<<'\n';
	}
    }
  cout<<tot<<'\n';
}
