library(devtools)
install_github("MoisesExpositoAlonso/rbioclim")
library(raster)
library(rbioclim)

r<-getTerra(listyears=1958) # safer to download only one file
r

plot(r[[1]][1])
