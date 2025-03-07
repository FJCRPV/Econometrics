clear
cd "C:\Users\Francisco\Desktop\Econometrics\Project\"
import excel "Unrestricted Input.xlsx", firstrow
save "Unrestricted Input.dta", replace
use "Unrestricted Input.dta", clear
generate Developed = 0 if DevelopedvsDeveloping=="Developing"
replace Developed = 1 if DevelopedvsDeveloping=="Developed"
generate lnGDPpercapitaPPPcurrentint = log(GDPpercapitaPPPcurrentint)
pwcorr Lifeexpectanc~l Laborforcewit~t Governmentexp~e lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
regress Lifeexpectanc~l  Laborforcewit~t Governmentexp~e lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
drop Governmentexpenditureperstude
pwcorr Lifeexpectanc~l Laborforcewit~t lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
regress Lifeexpectanc~l  Laborforcewit~t lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed
estat hettest, rhs fstat
estat imtest, white
predict uhat, residuals
generate uhatsq = uhat^2
predict yhat, xb
generate yhatsq = yhat^2
regress uhatsq yhat yhatsq
regress Lifeexpectanc~l  Laborforcewit~t lnGDPpercapit~t Grossdomestic~P Unemploymentt~l Currenthealth~f Totalalcoholc~a Smokingpreval~s Urbanpopulati~p Developed, vce (robust)
kdensity uhat, normal
save "Restricted Input", replace
