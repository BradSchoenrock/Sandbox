//53
using namespace std;

long long int highfactor(long long int high)
{
  //cout<<high<<'\n';
  for(long long int fact=sqrt(high);fact>1;fact--)
    if(high%fact==0)
      if(highfactor(fact)==0)
	return fact;
  return 0;
}

int choose(int n, int r)
{
  long long int choose;

  vector<int> num;
  vector<int> denom;
  
  for(int a=n;a>1;a--)
    {
      int temp=a;
      int fact=highfactor(temp);
      while(fact!=0)
	{
	  num.push_back(fact);
	  temp=temp/fact;
	  fact=highfactor(fact);
	}
      if(temp>1)
	num.push_back(temp);
    }
  for(int b=r;b>1;b--)
    {
      int temp=b;
      int fact=highfactor(temp);
      while(fact!=0)
	{
	  denom.push_back(fact);
	  temp=temp/fact;
	  fact=highfactor(fact);
	}
      if(temp>1)
	denom.push_back(temp);
    }
  for(int c=n-r;c>1;c--)
    {
      int temp=c;
      int fact=highfactor(temp);
      while(fact!=0)
	{
	  denom.push_back(fact);
	  temp=temp/fact;
	  fact=highfactor(fact);
	}
      if(temp>1)
	denom.push_back(temp);
    }
  
  for(int i=0;i<num.size();i++)
    {
      for(int j=0;j<denom.size();j++)
	{
	  if(num.at(i)==denom.at(j))
	    {
	      num.erase(num.begin()+i);
	      denom.erase(denom.begin()+j);
	      i=0;
	      j=0;
	    }
	}
    }

  /*  cout<<"num"<<'\n';
  for(int y=0;y<num.size();y++)
    cout<<num.at(y)<<'\n';
  
  cout<<"denom"<<'\n';
  for(int z=0;z<denom.size();z++)
    cout<<denom.at(z)<<'\n';
  */
 
  double thing=1;

  for(int i=0;i<denom.size();i++)
    thing=thing/denom.at(i);
  
  int q=0;
  while(thing<1000000 && q<num.size())
    thing=thing*num.at(q++);
  
  choose=(long long int)thing;
  
  return choose;
}

void CombSelections()
{
  cout<<choose(5,3)<<'\n';
  int ans=0;
  long long int temp;
  for(int n=22;n<=100;n++)
    for(int r=2;r<n;r++)
      {
  	temp=choose(n,r);
  	if(temp-1000000>0)
  	  {
  	    //cout<<n<<"   "<<r<<'\n';
  	    //cout<<temp<<'\n';
  	    ans++;
  	  }
      }
  cout<<ans<<'\n';
}
