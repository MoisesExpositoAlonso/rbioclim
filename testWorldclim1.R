library(devtools)
install_github("MoisesExpositoAlonso/rbioclim")
library(raster)
library(rbioclim)

r<-raster::getData(name = 'worldclim',res=5,var='bio')
plot(r[[1]])
dim(r)
?getData
r<-getTerra(listyears=1958) # safer to download only one file
r

plot(r[[1]][1])
