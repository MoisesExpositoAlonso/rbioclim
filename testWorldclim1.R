library(devtools)
install_github("MoisesExpositoAlonso/rbioclim")
library(raster)
library(rbioclim)

r<-rbioclim::getData(name = 'worldclim',res=5,var='bio')
plot(r[[1]])
dim(r)
