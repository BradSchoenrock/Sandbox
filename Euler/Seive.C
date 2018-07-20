

using namespace std;

void Seive()
{
  const int high=200000;
  bool pos[high];
  
  for(int n=0;n<high;n++)
    {
      pos[n]=true;
    }
  for(int k=2;k<high;k++)
    if(pos[k]==true)
      for(int f=k+k;f<high;f=f+k)
	pos[f]=false;
    
  int nprimes=0;
  for(int i=2;i<high;i++)
    {
      if(pos[i]==true)
	{
	  //cout<<i<<'\n';
	  nprimes++;
	  if(nprimes==10001)
	    cout<<i<<'\n';
	}
    }
  cout<<"nprimes="<<nprimes<<'\n';
}
