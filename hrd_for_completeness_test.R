library("ggplot2")

# These two functions use polynomial fits obtained with fit.R
# to convert observed color to temperature Teff and bolometric correction BC
get_logTeff <- function (bp_rp) {
  bp_rp0  = bp_rp - 0.41*0.5   # reddening corr.: Wang,Chen+2019, Zaritsky+2004
  logTeff = 3.98591127 - 0.65681174*bp_rp0 + 0.76283702*bp_rp0^2 - 
            0.47031180*bp_rp0^3 + 0.09898023*bp_rp0^4
  return(logTeff)
}

get_logL <- function(bp_rp, phot_bp_mean_mag) {
  bp_rp0 = bp_rp - 0.5 * 0.41
  Gbp0   = phot_bp_mean_mag - 0.5 * 1.002  # extinction corr. same refs logTeff 
  BC     = 0.2547454 + 2.5632543*bp_rp0 - 5.0847357*bp_rp0^2 + 
           2.9441443*bp_rp0^3 - 0.6093457*bp_rp0^4
  logL   = -0.4 * (Gbp0 -18.493 - 4.74 + BC) # 18.493: DM from Pietrzynski+2013
  return(logL)                               # 4.74: Solar absolute magnitude   
}

## LOAD DATA, create a few new columns
setwd("C:/Users/hp/Desktop/etteren_projects/ASTRO_REST/collaboreren/2025pauli")
dall <- read.csv('alllmc_logl_4p5plus.csv')  # most complete LMC data
dp   <- read.csv('VFTS_full_x_DR3.csv')      # subsable, completeness tbd
##dall$logL_Rabel <- get_logL(dall$bp_rp,dall$phot_bp_mean_mag)  # used to check: identical to ADQL
dall$logTeff_phot <- get_logTeff(dall$bp_rp)
dp$logL_phot      <- get_logL(dp$BP.RP,dp$BPmag)
dp$logTeff_phot   <- get_logTeff(dp$BP.RP)


# PLOT DATA
plot_what <- 'cmd'   # cmd/hrd; Hertzsprung-Russell or Color-Magnitude Diagram?

if (plot_what == 'hrd') {  # HRD
  p<- ggplot( ) + 
    geom_point( alpha=0.1, data=dall, aes( x=logTeff_phot, y=logL_abel, color='GAIA phot') )+
    #geom_point( alpha=0.5, color='orange',data=dp,  aes( x=logTeff_phot, y=logL_phot, color='Pauli')) + 
    geom_point( alpha=0.5,data=dp,  aes( x=log10(Teff), y=logL, color='VFTS')) + 
    scale_color_manual(values = c("GAIA phot" = "blue", "VFTS" = "orange")) +
    labs(x = "logTeff", y = "logL", color = "Dataset") +
    xlim(5,3.5) + ylim(3,6.5) +
    theme_minimal()
}

if (plot_what == 'cmd') {  # CMD
p<- ggplot( ) + 
  geom_point( alpha=0.1, data=dall, aes( x=bp_rp, y=phot_bp_mean_mag, color='GAIA') )+
  geom_point( alpha=0.5, data=dp,   aes( x=BP.RP, y=BPmag, color='VFTS')) + 
  scale_color_manual(values = c("GAIA" = "blue", "VFTS" = "orange")) +
  ylim(20,10)
}

p