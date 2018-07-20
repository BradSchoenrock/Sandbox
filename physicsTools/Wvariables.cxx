#include "Wvariables.h"
#include "KinematicUtils.cxx"
#include "TLorentzVector.h"
#include <cmath>

namespace Wvariables {

  double WtransverseMass(double leptonPT, double leptonPhi, double MET, double METphi) {
    double leptonPX=leptonPT*std::cos(leptonPhi);
    double leptonPY=leptonPT*std::sin(leptonPhi);
    double METx=MET*std::cos(METphi);
    double METy=MET*std::sin(METphi);    
    double WMT=std::sqrt(std::pow(leptonPT+MET,2)-std::pow(leptonPX+METx,2)-std::pow(leptonPY+METy,2));
    return WMT;
  }
  
//-------------------------------------------------------------------------------

  TLorentzVector Wneutrino(double MET, double METphi, double leptonPT, double leptonEta, double leptonPhi) {
    double mW=80.4;
    double neutrinoPX=0;
    double neutrinoPY=0;
    double neutrinoPZ=0;
    TLorentzVector lepton;
    lepton.SetPtEtaPhiM(leptonPT, leptonEta, leptonPhi, 0);
    double leptonPZ=lepton.Pz();
    double mu=(std::pow(mW,2)/2)+std::cos(KinematicUtils::deltaPhi(METphi,leptonPhi))*MET*leptonPT;
    double determinant = (std::pow(mu,2)*std::pow(leptonPZ,2)/std::pow(leptonPT,4))-(std::pow(MET,2)*(std::pow(leptonPT,2)+std::pow(leptonPZ,2))-std::pow(mu,2))/std::pow(leptonPT,2);
    if (determinant<0){
      MET=(1.+std::cos(KinematicUtils::deltaPhi(METphi,leptonPhi)))*std::pow(mW,2)/(2*leptonPT*std::pow(std::sin(KinematicUtils::deltaPhi(METphi,leptonPhi)),2));
      mu=(std::pow(mW,2)/2)+std::cos(KinematicUtils::deltaPhi(METphi,leptonPhi))*MET*leptonPT;
      determinant=0.;
    }
    double neutrinoPZplus=(mu*leptonPZ/std::pow(leptonPT,2))+std::sqrt(determinant);
    double neutrinoPZminus=(mu*leptonPZ/std::pow(leptonPT,2))-std::sqrt(determinant);
    neutrinoPZ=neutrinoPZminus;
    if(std::fabs(neutrinoPZplus)<std::fabs(neutrinoPZminus)){
      neutrinoPZ=neutrinoPZplus;
    }
    neutrinoPX=MET*std::cos(METphi);
    neutrinoPY=MET*std::sin(METphi);
    TLorentzVector neutrino;
    neutrino.SetPxPyPzE(neutrinoPX,neutrinoPY,neutrinoPZ,std::sqrt(std::pow(neutrinoPX,2)+std::pow(neutrinoPY,2)+std::pow(neutrinoPZ,2)));
    return  neutrino;
  }

//-------------------------------------------------------------------------------

  TLorentzVector reconstructedW(double MET, double METphi, double leptonPT, double leptonEta, double leptonPhi) {
    //double mW=80.4;
    TLorentzVector neutrino=Wneutrino(MET,METphi,leptonPT,leptonEta,leptonPhi);
    TLorentzVector lepton;
    lepton.SetPtEtaPhiM(leptonPT, leptonEta, leptonPhi, 0);
    TLorentzVector reconW=neutrino+lepton;
    return  reconW;
  }

  /*
  //-------------------------------------------------------------------------------
  
  TLorentzVector topJet(JetContainer* jets, TLorentzVector W, int nTagged) {
  double m_t=172.5;
  double mW=80.4;
  TLorentzVector neutrino=Wneutrino(double MET, double METphi, double leptonPT, double leptonEta, double leptonPhi);
  TLorentzVector lepton.SetPtEtaPhiM(leptonPT, leptonEta, leptonPhi, 0);
  TLorentzVector reconW=neutrino+lepton;
  return  bestTopJet;
  }
  
  
  
  
  //-------------------------------------------------------------------------------
  
  double WprimeMass(double ptLep, double phiLep, double met, double phiMet) {
  return std::sqrt(2.0*ptLep*met*( 1 - std::cos( phiLep-phiMet ) ) );
  }
  */
}
