
using namespace std;

void PentagonNumbers()
{
  int howfar=10000;
  
  long int mindiff=99999999;
    
  for(int i=1;i<howfar-1;i++)
    {
      for(int j=i+1;j<howfar;j++)
	{
	  long int sum=GenPent(i)+GenPent(j);
	  long int diff=abs(GenPent(i)-GenPent(j));

	  if(ispent(sum)&&ispent(diff)&&diff<mindiff)
	    {
	      cout<<"GenPent(i)="<<GenPent(i)<<'\n';
	      cout<<"GenPent(j)="<<GenPent(j)<<'\n';
	      cout<<"sum="<<sum<<'\n';
	      cout<<"diff="<<diff<<'\n';
	      cout<<"mindiff="<<mindiff<<'\n';
	      cout<<'\n';
	      mindiff=diff;
	    }
	}
    }
  cout<<"final_answer="<<mindiff<<'\n';
}

bool ispent(int totest)
{
  double check=(1+sqrt(1+24*totest))/6;
  if( check==(int)check )
    return true;
  return false;
}

int GenPent(int i)
{
  return 3/2.0*i*i-i/2.0;
}
