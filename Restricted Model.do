cd "C:\Users\Francisco\Desktop\Econometrics\Project\"
use "Restricted Input.dta", clear
describe
regress Lifeexpectanc~l  Laborforcewit~t lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
predict uhat, residuals
generate uhatsq = uhat^2
generate loguhatsq = log(uhatsq)
regress loguhatsq Laborforcewit~t lnGDPpercapitaP~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
predict yhat, xb
drop yhat
predict ghat, xb
gen hhat = exp(ghat)
gen sqrthhat = hhat^(0.5)
regress Lifeexpectanc~l  Laborforcewit~t lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed [aweight = 1/(sqrthhat)]
estat hettest, rhs fstat
predict newuhat, residuals
generate newuhatsq = newuhat^2
predict newyhat, xb
gen newyhatsq = newyhat^2
regress newuhatsq newyhat newyhatsq
