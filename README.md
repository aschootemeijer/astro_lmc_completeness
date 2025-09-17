# astro_lmc_completeness
In this project we investigate the completeness of the VFTS catalog of massive stars in the Large Magellanic Cloud (LMC). We use the GAIA catalog to estimate how many massive stars there are in total in the LMC.

We take the following steps:
- fit.R: the GAIA catalog provides photometry. To calculate luminosities from this, we need a relation between color and bolometric correction. For this we use an R script called fit.R
- luminous_lmc_stars.adql: in https://gea.esac.esa.int/archive/ we enter this query. It selects LMC stars above a certain luminosity. ADQL is similar to SQL (it stands for Astronomical Data Query Language).
- O_stars.adql: similar to the luminous_lmc_stars.adql, but it requires that stars have an inferred temperature above 30kK (corresponding to O star temperatures) 
- hrd_for_completeness_test.R: plot the (most) complete data obtained with the ADQL script and the data from the VFTS catalog in a Hertzsprung-Russell Diagram (HRD). This way we can investigate the completeness of the VFTS catalog. It is also possible to show the data in a Color-Magnitude Diagram (CMD) instead.
