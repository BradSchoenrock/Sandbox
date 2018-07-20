#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

void stringplaying()
{
  std::string st="../work/rootfiles_egamma/validationrootfiles/NTUP_EGAMMA.00815501._000022.root";
  std::string s1;
  std::string s2;

  cout<<st<<'\n''\n';

  s1=st.substr(45,28);
  s2=s1+"_trimmed"+".root";

  cout<<st<<'\n'<<s1<<'\n'<<s2<<'\n'<<'\n';

  cout<<"i'm done"<<'\n';
  
  
}
