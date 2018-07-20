
using namespace std;

void MostConsecutivePrimes()
{
  const int high=1000000;
  bool pos[high];
  
  for(int n=0;n<high;n++)
    {
      pos[n]=true;
    }
  for(int k=2;k<high;k++)
    if(pos[k]==true)
      for(int f=k+k;f<high;f=f+k)
	pos[f]=false;
    
  long int nprimes=0;
  vector<int> primes;

  for(int i=2;i<high;i++)
    {
      if(pos[i]==true)
	{
	  nprimes++;
	  primes.push_back(i);
	  //cout<<"i="<<i<<'\n';
	  //cout<<"nprimes="<<nprimes<<'\n';
	}
    }
  
  cout<<"done Seiveing"<<'\n';
  cout<<"nprimes="<<nprimes<<'\n';
  long int sum=0;
  int prime=0;
  for(int n=1000;n>20;n--)
    {
      cout<<"n="<<n<<'\n';
      for(int i=0;i<nprimes-n;i++)
	{
	  if(i%10000==0)
	    cout<<"i="<<i<<'\n';
	  for(int c=0;c<n;c++)
	    sum=sum+primes.at(i+c);
	  if(sum<high && pos[sum])
	    {
	      prime=sum;
	      cout<<prime<<" is the sum of "<<'\n';
	      for(int c=0;c<n;c++)
	      	cout<<primes.at(i+c)<<'\n';
	      return;
	    }
	  sum=0;
	}
    }

  cout<<prime<<'\n';

}
