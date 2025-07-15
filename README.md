# astro_lmc_completeness
In this project we investigate the completeness of a catalog of massive stars in the Large Magellanic Cloud (LMC). We use the GAIA catalog to estimate how many massive stars there are in total in the LMC.

We take the following steps:
- fit.R: the GAIA catalog provides photometry. To calculate luminosities from this, we need a relation between color and bolometric correction. For this we use an R script called fit.R
- luminous_lmc_stars.adql: in https://gea.esac.esa.int/archive/ we enter this query. It selects LMC stars above a certain luminosity. ADQL is similar to SQL, AD stands for Astronomical Data Query Language. 
