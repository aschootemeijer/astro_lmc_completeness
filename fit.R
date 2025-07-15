library("ggplot2")
d <- read.table("UBVRIplus_202507/fehm025.UBVRIplus", header=TRUE)

# now select a subset of the data and make some new columns
d <- d[ 
  d$logg == 0 & d$Av==0 & d$Teff > 3300 & d$Teff<5e4,  
  c("Teff", "Gaia_G_EDR3", "Gaia_BP_EDR3", "Gaia_RP_EDR3")]
d$logTeff <- log10(d$Teff)
d$bp_rp   <- -d$Gaia_BP_EDR3 + d$Gaia_RP_EDR3 
head(d)

# fit a nth order polynomial
fit <- lm( Gaia_BP_EDR3 ~ poly(bp_rp, 4, raw=TRUE), data=d)
cat( "\n These are the polyfit coefficients:" )
print( coef(fit) )

# work on showing the fit
x <- seq( min(d$bp_rp), max(d$bp_rp), length=100 )
fitdata <- data.frame( bp_rp=x ) # it has to be called x because it is so in fit
fitdata$yfit <- predict(fit, newdata = fitdata )

# plot data and the fit
p <- ggplot(data = d, aes(bp_rp, Gaia_BP_EDR3)  ) +
  geom_point(color='orange') +
  geom_line( data = fitdata, aes(x=bp_rp, y=yfit))
p