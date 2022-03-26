year=2000
getAVHRR<-function(year=2018){
  require(raster)
  require(XML)
  require(RCurl)
  # url from NOAA data
  url<-sprintf("https://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/%s/",year)
  xData <- getURL(url)
  # parse the files within the year
  doc<-getHTMLLinks(xData)
  doc<-doc[which(grepl("AVHRR-Land",doc))]
  f<-doc[10] # example with one doc
  # for(i in doc){}
  # url <- "https://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/1981/"
  # f <- "AVHRR-Land_v005_AVH13C1_NOAA-07_19810624_c20170610041337.nc"
  r<-lapply(doc,function(f){
    if (!file.exists(f)) download.file(file.path(url, f), f, mode="wb")
    #Loading required package: sp
    raster(f, varname="NDVI")
  }) %>% raster::stack
  # r
  # plot(r)
  #Loading required namespace: ncdf4
}


library(dplyr)
test<-getAVHRR(year = 2018)

#class      : RasterLayer
#dimensions : 3600, 7200, 25920000  (nrow, ncol, ncell)
#resolution : 0.05, 0.05  (x, y)
#extent     : -180, 180, -89.99999, 90  (xmin, xmax, ymin, ymax)
#crs        : +init=EPSG:4326 +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0
#source     : AVHRR-Land_v005_AVH13C1_NOAA-07_19810624_c20170610041337.nc
#names      : NOAA.Climate.Data.Record.of.Normalized.Difference.Vegetation.Index
#z-value    : 1981-06-24
#zvar       : NDVI

#
# url <- "https://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/1981/"
#
# library(XML)
# https://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/1990/
#
# library(XML)
# url <- "http://cran.r-project.org/src/contrib/Archive/Amelia/"
# doc <- htmlParse(url)
# links <- xpathSApply(doc, "//a/@href")
# free(doc)
# links
#
# library(Rcurl)
# result <- getURL(url,verbose=TRUE,ftp.use.epsv=TRUE, dirlistonly = TRUE)
# result <- curl(url)
#
#
# library(XML)
# getHTMLLinks(url)
#
# ?getHTMLLinks(baseURL = "https://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/2021/")
#
#
# try(getHTMLLinks("http://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/2021/"))
#
# getHTMLLinks(getURL("http://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/2021/"))
#
#
#
# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# fileURL<- "http://www.ncei.noaa.gov/data/avhrr-land-normalized-difference-vegetation-index/access/2021/"
#
#
