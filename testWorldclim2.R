# https://www.worldclim.org/data/worldclim21.html

library(raster)
library(devtools)
install_github("MoisesExpositoAlonso/rbioclim")
library(rbioclim)
# devtools::load_all(".")

r<-.worldclim2(var='wind',res = 10,path = '~/')
dim(r)
plot(r[[1]])
