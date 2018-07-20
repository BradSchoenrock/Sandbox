#include <vector>
#include <iostream>
using namespace std;

void Printvecvec(vector< vector<int*> > vec)
{
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 20; j++) {
      cout<<"*vec["<<i<<"]["<<j<<"]="<<*((vec.at(i)).at(j))<<'\n';
    }
  }
}

int main(int argc, char **argv) {
  
  vector< vector<int*> > vec;
  vector<int*> row; 
  int* k;
  
  vec.push_back(row);
  
  for (int i = 0; i < 10; i++) {
    //cout<<"i="<<i<<'\n';
    vec.push_back(row);
    for (int j = 0; j < 20; j++) {
      //cout<<"j="<<j<<'\n';
      int q=i*j;
      int* u;
      //cout<<"k="<<k<<'\n';
      //cout<<"  *k="<<*k<<'\n';
      (vec.at(i)).push_back(u);
      *((vec.at(i)).at(j))=q;
    }
  }
  
  Printvecvec(vec);
  
  return(0);
}


