#include "TCanvas.h"
#include "TPaletteAxis.h"
using namespace std;

//an example for resizing a TPaletteAxis

void plot()
{

   TCanvas *c1 = new TCanvas("c1","c1",600,400);
   TH2F *h2 = new TH2F("h2","Example of a resized palette ",40,-4,4,40,-20,20);
   Float_t px, py;
   for (Int_t i = 0; i < 25000; i++) {
      gRandom->Rannor(px,py);
      h2->Fill(px,5*py);
   }
   gStyle->SetPalette(1);
   h2->Draw("COLZ");
   gPad->Update();
	
   TList *mylist=h2->GetListOfFunctions();

   mylist->Print();

   TPaletteAxis *palette = (TPaletteAxis*)mylist->FindObject("palette");
   palette->SetY2NDC(0.7);
   h2->Draw("COLZ");
   //gStyle->SetOptStat(0);
   gPad->Update();

   //return c1;
}
