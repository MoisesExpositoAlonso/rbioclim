# https://www.worldclim.org/data/worldclim21.html

library(raster)
library(devtools)
install_github("MoisesExpositoAlonso/rbioclim")
library(rbioclim)
# devtools::load_all(".")

r<-rbioclim::getData(name = 'worldclim2',res=5,var='bio')
dim(r)
plot(r[[1]])
projec
