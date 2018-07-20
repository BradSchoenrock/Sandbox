

using namespace std;

void James2()
{
  const int high=350;
  int pos[high];
  
  for(int n=0;n<high;n++)
    {
      pos[n]=n;
    }
  for(int k=2;k<high;k++)
    if(pos[k]>0)
      for(int f=k+k;f<high;f=f+k)
	pos[f]=-1;
  
  long double maxi=1;
  double num=0;
  
  int nprimes=0;
  for(int i=high-1;i>1;i--)
    {
      if(pos[i]>0)
	{
	  cout<<pos[i]<<'\n';
	  nprimes++;
	  for(int k=0;k<nprimes;k++)
	    {
	      maxi=maxi*pos[i];
	      num=num+pos[i];
	    }
	}
    }
  double maxfrac=num/i;
  //cout.setf(ios::fixed);
  cout<<setprecision(1000)<<maxi<<" has a highly composite index of ";
  cout<<setprecision(10)<<maxfrac<<'\n';
}
