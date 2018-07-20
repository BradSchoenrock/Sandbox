
using namespace std;

void ThousDigitFib()
{
  long long int a=1;
  long long int b=2;
  long long int c=3;

  long long int i=4;

  for(long long int p=0;p<5000;p++)
    {
      a=b;
      b=c;
      c=a+b;
      i++;
      //cout<<"c="<<c<<"   i="<<i<<'\n';
    }
  cout<<c<<'\n';
  cout<<i<<'\n';
}
