


using namespace std;


void James()
{
  double maxfrac=0;
  int maxi=0;
  int N=100000;
  for(int i=1;i<N;i++)
    {
      int num=0;
      for(int j=2;j<=i/2;j++)
	{
	  if(i%j==0)
	    num+=j;
	}
      double den=i;
      double x=num/den;
      //cout<<"i="<<i<<"   "<<"frac="<<x<<'\n';
      if(x>maxfrac)
	{
	  cout<<"i="<<i<<"   "<<"frac="<<x<<'\n';
	  maxfrac=x;
	  maxi=i;
	}
    }
  cout<<'\n';
  cout<<"maxi="<<i<<"   "<<"maxfrac="<<x<<'\n';
  cout<<"bye"<<'\n';
}
