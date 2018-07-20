void LargestPrimeFactor()
{
  const long long int high=600851475143;
  cout<<highfactor(13195)<<'\n';
  cout<<highfactor(high)<<'\n';
}
long long int highfactor(long long int high)
{
  //cout<<high<<'\n';
  for(long long int fact=sqrt(high);fact>1;fact--)
    if(high%fact==0)
      if(highfactor(fact)==0)
	return fact;
  return 0;
}
