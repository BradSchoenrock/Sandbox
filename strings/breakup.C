#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>

#include 

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

void breakup()
{
  ifstream fin("inputFiles.txt");

  if(fin.fail())
    {
      cout<<"File not found"<<'\n';
      exit(1);
    }
  else
    {
      string line;
      string onefile;
      string directory;
      string temp="_trimmed.root";
      string all;
      int counter=0;
      while(!fin.eof())
	{
	  counter++;
	  std::getline(fin, line);
	  //cout<<counter<<") "<<line<<'\n';

	  directory=line.substr(49,92);

	  onefile=line.substr(141,28);
	  onefile=onefile+temp;

	  all=directory+onefile;

	  cout<<"directory="<<directory<<'\n'<<"onefile="<<onefile<<'\n'<<"all="<<all<<'\n'<<'\n';

	  ofstream outfile(directory+onefile);

	  //outfile<<onefile;

	  outfile.close();
	  
	}
    }
}
