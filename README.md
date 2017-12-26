# rbioclim: Improved getData function from the raster R package to interact with past, present and future climate data from worldclim.org. 

*Need to update the package to v2. There might be building problems!*

All the data retrieved by this package is publicly available at worldclim.org, so visit the page for details and new releases.

Cite the data as:

[Hijmans, Robert J., Susan E. Cameron, Juan L. Parra, Peter G. Jones, and Andy Jarvis. 2005. “Very High Resolution Interpolated Climate Surfaces for Global Land Areas.” International Journal of Climatology 25 (15). John Wiley & Sons, Ltd.: 1965–78.](http://onlinelibrary.wiley.com/doi/10.1002/joc.1276/pdf)

You can refer to this repo as:

M. Exposito-Alonso (2017) rbioclim: Improved getData function from the raster R package to interact with past, present and future climate data from worldclim.org. github.com/MoisesExpositoAlonso/rbioclim

For bugs or questions, send an email to:
moisesexpositoalonso@gmail.com

## Details

The motivation of this package is to have a rapid access to all time layers available at worldclim.org (needed it for my analyses).

The package includes an improved getData function from the rater package that not only allows the tipical import of present data or IPCC5 daata (2050 & 2070 future), but also the last glacial maxima and mid-holocene datasets. It also includes several wrapper functions to download all available datasets at worldclim with a single command.


## How to ...
### Install the package and get the bioclim data just run:

``` sh
library(raster)
devtools::install_github("MoisesExpositoAlonso/rbioclim") # change exp to master when branches are merted
library(rbioclim)

bioclim = recursive.getData(times="all") # by default resolution 2.5m and the 19 bioclim variables. (but can be changed)

```

### Extract layers and start playing around with the data

``` sh
# Example how to extract the current climate. (Layers have the same name as the zip file but without the .zip)
currentclimate<-bioclim[["pres"]]
# Or last glaciation:
lastglaciation<-bioclim[["lgm"]]
# Or for projections under rpc 6.0 to the year 2050:
cc602050<-bioclim[["CC6050"]]

# And you can plot it
plot(currentclimate[["bio1"]])
plot(lastglaciation[["bio1"]])
plot(currentclimate[["bio1"]]- lastglaciation[["bio1"]] ) # the increase in annual temperature
``` 

## Further details

### The datasets you can download are:

``` sh
pres  = current climatic data, average 1960-1990.
lgm  = Last Glacial Maximum data (22,000 years ago) from global climate model
mid  = Mid Holocene data (6,000 years ago) from global climate model
CC2650      = 2050 climate from glocal climate model from 5th IPCC. scennario rcp 2.6
CC2670      = 2070 climate from glocal climate model from 5th IPCC. scennario rcp 2.6
CC4550      = 2050 climate from glocal climate model from 5th IPCC. scennario rcp 4.5
CC4570      = 2070 climate from glocal climate model from 5th IPCC. scennario rcp 4.5
CC6050      = 2050 climate from glocal climate model from 5th IPCC. scennario rcp 6.0
CC6070      = 2070 climate from glocal climate model from 5th IPCC. scennario rcp 6.0
CC8550      = 2050 climate from glocal climate model from 5th IPCC. scennario rcp 8.5
CC8570      = 2070 climate from glocal climate model from 5th IPCC. scennario rcp 8.5
```

### The 19 bioclim variables are below. (Available are also minimum and maximum temperatures and precipitation per month)

``` sh
BIO1 = Annual Mean Temperature
BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
BIO3 = Isothermality (BIO2/BIO7) (* 100)
BIO4 = Temperature Seasonality (standard deviation *100)
BIO5 = Max Temperature of Warmest Month
BIO6 = Min Temperature of Coldest Month
BIO7 = Temperature Annual Range (BIO5-BIO6)
BIO8 = Mean Temperature of Wettest Quarter
BIO9 = Mean Temperature of Driest Quarter
BIO10 = Mean Temperature of Warmest Quarter
BIO11 = Mean Temperature of Coldest Quarter
BIO12 = Annual Precipitation
BIO13 = Precipitation of Wettest Month
BIO14 = Precipitation of Driest Month
BIO15 = Precipitation Seasonality (Coefficient of Variation)
BIO16 = Precipitation of Wettest Quarter
BIO17 = Precipitation of Driest Quarter
BIO18 = Precipitation of Warmest Quarter
BIO19 = Precipitation of Coldest Quarter
```




