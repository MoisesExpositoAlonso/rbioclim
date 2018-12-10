#' getTerra
#' Query and load into R data from http://www.climatologylab.org/terraclimate.html
#'
#' @param start start
#' @param end
#' @param byyear
#' @param listyears Instead of start, end, and byyer, user can provide the list of year
#' @param path by default, "data"
#' @variableclim either tmax, tmin, ppt
#'
#' @return list of rasterstack
#' @export
#'
#'
getTerra<-function(start=1958,end=2017,byyear=10,listyears=NULL,variableclim='ppt',path='data'){
  stopifnot(variableclim %in% c('tmax','tmin','ppt'))
  stopifnot(start>=1958)
  stopifnot(end<2018)
  stopifnot(start<end)
  stopifnot(byyear>=1 )
  if(is.null(listyears)) listyears<-seq(start,end,byyear)

  require(raster)

  # helper functions
   # .query<-function(terrafile,path){
   #    message("Downloading terraclimate layer ", terrafile)
   #    cmd<-paste0('wget / https://climate.northwestknowledge.net/TERRACLIMATE-DATA/',terrafile,' ')
   #    system(cmd)
   # }
 .download <- function(path,terrafile, downloadmethod="wget") {
      aurl=paste0('https://climate.northwestknowledge.net/TERRACLIMATE-DATA/',gsub(pattern = "\\.nc$", "", terrafile))
      filename<-paste0(path,"/",terrafile)
      fn <- paste(tempfile(), '.download', sep='')
      res <- utils::download.file(url=aurl, destfile=fn, method=downloadmethod, quiet = FALSE, mode = "wb", cacheOK = TRUE) # other people and me problem with method="auto"
      if (res == 0) {
        w <- getOption('warn')
        on.exit(options('warn' = w))
        options('warn'=-1)
        if (! file.rename(fn, filename) ) {
          # rename failed, perhaps because fn and filename refer to different devices
          file.copy(fn, filename)
          file.remove(fn)
        }
        } else {
          stop('could not download the file' )
        }
      }
  .files<-function(path,variableclim,listyears){
      return(paste0("TerraClimate_",variableclim,"_",listyears,".nc"))
  }
  .checkfiles<-function(path,terrafile){
    foundfiles<-list.files(path = path,pattern = paste0("TerraClimate_"),full.names = T)
    if(paste0(path,"/",terrafile) %in% foundfiles){
      return(TRUE)
    }else{
      return(FALSE)
    }
  }
  .read<-function(terrafiles){
    rall = lapply(terrafiles,function(myr) {
      message(myr)
      rtmp=stack(lapply(1:12, function(i) raster(myr,band=i,ncdf=TRUE)))
      crs(rtmp)<- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
      return(rtmp)})
    return(rall)
  }
  .getTerra<-function(...){
    terrafiles<-.files(path,variableclim,listyears)
    for (i in terrafiles){
      if(!.checkfiles(path,i)){
        .download(path,i)
      }
    }
    r<-.read(paste0(path,"/",terrafiles))
    # message('Saving .gri/.grd files into ',paste0("data/terraclimate-",variableclim))
    # raster::writeRaster(r,filename = paste0("data/terraclimate-",variableclim), overwrite=T)
    return(r)
    }
  # action
  r<-.getTerra(start,end,byyear,listyears,variableclim,path)
  message('Done')
  return(r)
}

