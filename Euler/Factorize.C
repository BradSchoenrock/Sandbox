//gives the prime factorization of a number

int highfactor(int high)
{
  for(int fact=high-1;fact>1;fact--)
    if(high%fact==0)
      if(highfactor(fact)==0)
	return fact;
  return 0;
}

vector<int> Factorize(int num)
{
  vector<int> ans;
 
  int fact=highfactor(num);
  while(fact>0)
    {
      //cout<<fact<<"   "<<num<<'\n';
      ans.push_back(fact);
      num=num/fact;
      if(highfactor(num)==0)
	{
	  ans.push_back(num);
	}
      fact=highfactor(num);
    }
  
  return ans;
}
