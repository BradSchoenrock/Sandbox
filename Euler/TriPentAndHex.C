
using namespace std;

void TriPentAndHex()
{
  bool found=false;
  int y=286;
  while(!found)
    {
      int test=GenTri(y);
      cout<<GenTri(y)<<'\n';
      cout<<istri(test)<<'\n';
      cout<<ispent(test)<<'\n';
      cout<<ishex(test)<<'\n';
      
      if( istri(test) && ispent(test) && ishex(test) )
	found=true;
      y++;
    }
  std::cout.precision(10);
  cout<<GenTri(y-1)<<'\n';
}

bool istri(int totest)
{
  double check=(-1+sqrt(1+8*totest))/2;
  if( check==(int)check )
    return true;
  return false;
}

bool ispent(int totest)
{
  double check=(1+sqrt(1+24*totest))/6;
  if( check==(int)check )
    return true;
  return false;
}

bool ishex(int totest)
{
  double check=(1+sqrt(1+8*totest))/4;
  if( check==(int)check )
    return true;
  return false;
}

int GenTri(int i)
{
  return i*i/2.0+i/2.0;
}
