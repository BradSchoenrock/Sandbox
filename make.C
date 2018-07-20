#include <iostream>
#include <fstream>
#include "TFile.h"
#include "TTree.h"
#include "TLeaf.h"
#include "TH1.h"
#include "TH2.h"
#include "TCanvas.h"
#include "TLorentzVector.h"
#include "TString.h"
#include "TStyle.h"
#include "TLegend.h"

using namespace std;

void make()
{

  //gROOT->ForceStyle(); 
  //gStyle->SetOptStat(0);

  TFile * f1 = TFile::Open("output.root","recreate"); 
  f1->cd();

  TCanvas *c2 = new TCanvas("c2","c2",560,720);
  c2->SetBorderMode(0);
  c2->cd();
  


  TH1F *ExpectedPlot = new TH1F("Expected and Observed Limits","Expected and Observed Limits",12,0,12);
  TH1F *ObservedPlot = new TH1F("Expected and Observed Limits","Expected and Observed Limits",12,0,12);
  vector<string> binNames;

  binNames.push_back("TT_Singlet_Dilepton");
  binNames.push_back("TT_Singlet_Trilepton");
  binNames.push_back("TT_Singlet_Combination");
  binNames.push_back("BB_Singlet_Dilepton");
  binNames.push_back("BB_Singlet_Trilepton");
  binNames.push_back("BB_Singlet_Combination");
  binNames.push_back("TT_Doublet_Dilepton");
  binNames.push_back("TT_Doublet_Trilepton");
  binNames.push_back("TT_Doublet_Combination");
  binNames.push_back("BB_Doublet_Dilepton");
  binNames.push_back("BB_Doublet_Trilepton");
  binNames.push_back("BB_Doublet_Combination");
  //binNames.push_back("");

  vector<double> ExpectedLimits;

  ExpectedLimits.push_back(585);
  ExpectedLimits.push_back(620);
  ExpectedLimits.push_back(625);
  ExpectedLimits.push_back(665);
  ExpectedLimits.push_back(610);
  ExpectedLimits.push_back(670);
  ExpectedLimits.push_back(665);
  ExpectedLimits.push_back(700);
  ExpectedLimits.push_back(720);
  ExpectedLimits.push_back(750);
  ExpectedLimits.push_back(530);
  ExpectedLimits.push_back(755);
  //ExpectedLimits.push_back();

 vector<double> ObservedLimits;

  ObservedLimits.push_back(620);
  ObservedLimits.push_back(620);
  ObservedLimits.push_back(655);
  ObservedLimits.push_back(690);
  ObservedLimits.push_back(610);
  ObservedLimits.push_back(685);
  ObservedLimits.push_back(705);
  ObservedLimits.push_back(700);
  ObservedLimits.push_back(735);
  ObservedLimits.push_back(765);
  ObservedLimits.push_back(540);
  ObservedLimits.push_back(755);
  //ObservedLimits.push_back();

  assert(ExpectedLimits.size()==binNames.size());
  assert(ObservedLimits.size()==binNames.size());

  for(unsigned int i=0;i<binNames.size();i++)
    {
      ExpectedPlot->Fill(binNames[i].c_str(),0);
      ObservedPlot->Fill(binNames[i].c_str(),0);
   }
  
  //cout<<"a"<<'\n';

  for(unsigned int itll=0; itll<binNames.size();itll++)
    {
      cout<<(binNames.at(itll)).c_str()<<'\n';
      cout<<"Expected="<<ExpectedLimits.at(itll)<<'\n';
      cout<<"Observed="<<ObservedLimits.at(itll)<<'\n';
      cout<<'\n';

      ExpectedPlot->Fill( (binNames.at(itll)).c_str() , ExpectedLimits.at(itll) );
      ObservedPlot->Fill( (binNames.at(itll)).c_str() , ObservedLimits.at(itll) );
    }
  
  //cout<<"b"<<'\n';
  gStyle->SetOptStat(0);

   TLegend *leg = new TLegend(0.53,0.79,0.94,0.97);
  leg->SetFillColor(0);
  leg->SetLineColor(0);
  leg->SetShadowColor(0);
  
  leg->AddEntry(ExpectedPlot, "Expected", "P");
  leg->AddEntry(ObservedPlot, "Observed", "P");
  leg->SetTextFont(72);
  leg->SetTextSize(0.05);

  ExpectedPlot->SetAxisRange(400., 800.,"Y");
  ExpectedPlot->SetMarkerStyle(3);
  ExpectedPlot->SetMarkerColor(kRed);
  ExpectedPlot->SetMarkerSize(2);

  ObservedPlot->SetAxisRange(400., 800.,"Y");
  ObservedPlot->SetMarkerStyle(4);
  ObservedPlot->SetMarkerColor(kBlue);
  ObservedPlot->SetMarkerSize(2);

  
  //ExpectedPlot->Sumw2();
  ExpectedPlot->Draw("P");
  //ObservedPlot->Draw("P");
  ObservedPlot->Draw("SAMEP");

  leg->Draw();
  leg->Draw();

  ExpectedPlot->Write();
  ObservedPlot->Write();
  c2->Write();

  c2->SaveAs("CombinedHists.pdf");

}
