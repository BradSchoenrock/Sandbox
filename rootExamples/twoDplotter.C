#include "TCanvas.h"
#include "TPaletteAxis.h"
using namespace std;

//an example for resizing a TPaletteAxis

void twoDplotter()
{
  TCanvas *c1 = new TCanvas("c1","c1",600,400);
  TH2F *h2 = new TH2F("h2","Cross section as a function of xif and xir (fb)",16,0.45,2.05,16,0.45,2.05);
  Float_t xif=0.5;
  Float_t xir=0.5;
  string line;
  ifstream sampleFileIn="W+Zxsecs.txt";
  while(getline(sampleFileIn,line)) {
    stringstream lineStream;
    lineStream << line;
    Float_t weight; 
    lineStream>>weight;
    
    //gRandom->Rannor(px,py);
    h2->Fill(xir,xif,weight);

    //cout<<"xir="<<xir<<" "<<"xif="<<xir<<" "<<"weight="<<weight<<'\n';

    if(xir<2.0)
      xir+=0.1;
    else
      {
	xir=0.5;
	xif+=0.1;
      }
  }
  gStyle->SetPalette(1);
  h2->Draw("COLZ");
  gPad->Update();
  
  h2->GetXaxis()->SetTitle("xir");
  h2->GetYaxis()->SetTitle("xif");

  TList *mylist=h2->GetListOfFunctions();
  
  mylist->Print();
  
  TPaletteAxis *palette = (TPaletteAxis*)mylist->FindObject("palette");
  //palette->SetY2NDC(0.7);
  h2->Draw("COLZ");
  gStyle->SetOptStat(0);
  gPad->Update();
  
  //return c1;
}

