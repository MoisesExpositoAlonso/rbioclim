#' getTerra
#' Query and load into R data from http://www.climatologylab.org/terraclimate.html
#'
#' @param start
#' @param end
#' @param byyear
#' @param listyears
#' @param path
#'
#' @return
#' @export
#'
#' @examples
#' #Do not run
#' #
#'
getTerra<-function(start=1958,end=2017,byyear=5,listyears=seq(start,end,byyear),variableclim='ppt',path='data'){
  stopifnot(variableclim %in% c('tmax','tmin','ppt'))
  require(raster)

  # helper functions
   .query<-function(terrafile,path){
      message("Downloading terraclimate layer ", terrafile)
      # cmd<-paste0('wget https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate_',variableclim,'_',i,'.nc &')
      # cmd<-paste0('wget https://climate.northwestknowledge.net/TERRACLIMATE-DATA/',terrafile,' &')
      cmd<-paste0('wget --directory-prefix= ',path, ' https://climate.northwestknowledge.net/TERRACLIMATE-DATA/',terrafile,' ')
      system(cmd)
  }
  .files<-function(path,variableclim,listyears){
    return(paste0("TerraClimate_",variableclim,"_",listyears,".nc"))
  }
  .checkfiles<-function(path,terrafile){
    terrafiles<-list.files(path = path,pattern = paste0("TerraClimate_"),full.names = T)
    if(paste0(path,"/",terrafile) %in% terrafiles){
      return(TRUE)
    }else{
      return(FALSE)
    }
  }
  .read<-function(terrafiles){
    rall = lapply(terrafiles,function(myr) {
      message(myr)
      rtmp=stack(lapply(1:12, function(i) raster(myr,band=i,ncdf=TRUE)))
      # crs(rtmp) <- baseras@crs
      # r<-cropenvironment(rtmp,xlim = broadeuroextents()$xlim,ylim=broadeuroextents()$ylim)
      # r<-sum(r)
      return(rtmp)
  })
    return(rall)
  }
  .getTerra<-function(...){
    terrafiles<-.files(path,variableclim,listyears)
    for (i in terrafiles){
      if(!.checkfiles(path,i)){
        .query(path,i)
      }
    }
    r<-.read(terrafiles)
    message('Saving .gri/.grd files into ',paste0("data/terraclimate-",variableclim))
    raster::writeRaster(r,filename = paste0("data/terraclimate-",variableclim), overwrite=T)
    }

  # action
  r<-.getTerra(start,end,byyear,listyears,variableclim,path)
  message('Done')
  return(r)
}


# terrafiles<-list.files(path = "data-raw/",pattern = paste0("TerraClimate_",variableclim),full.names = T)
#
# # mytimes<-gsub("data-raw//TerraClimate_ppt_","",terrafiles)
# # mytimes<-gsub("data-raw//TerraClimate_tmax_","",terrafiles)
# mytimes<-gsub(paste0("data-raw//TerraClimate_",variableclim,"_"),"",terrafiles)
# mytimes<-gsub(".nc","",mytimes)

# rasterexample=raster(terrafiles[1],band=1,ncdf=TRUE)
# rasterexample=raster(terrafiles[1],level=2,ncdf=TRUE)
# rasterexample
# baseras<-makebaseraster()
# crs(rasterexample) <- baseras@crs
#
# stackexample=lapply(1:12, function(i) raster(terrafiles[1],band=i,ncdf=TRUE))
# stackexample=stack(stackexample)
# crs(stackexample) <- baseras@crs
# stackexample<-sum(stackexample)

# source("R/gem.R")
# source("R/euroextents.R")
#
# rall = lapply(terrafiles,function(myr) {
#   message(myr)
#   rtmp=stack(lapply(1:12, function(i) raster(myr,band=i,ncdf=TRUE)))
#   # crs(rtmp) <- baseras@crs
#   # r<-cropenvironment(rtmp,xlim = broadeuroextents()$xlim,ylim=broadeuroextents()$ylim)
#   r<-sum(r)
#   return(r)
# })
#
# rall
# rall_ = stack(rall)
# names(rall_)
# names(rall_)<-paste0(variableclim,mytimes)

# raster::writeRaster(rall_,filename = paste0("data-raw/terraclimate-",variableclim), overwrite=T)


# r<-rall_

#####**********************************************************************#####
#### Read again ####
# r<-raster(paste0("data-raw/terraclimate-",variableclim,'.grd'))

#####**********************************************************************#####
##### Extract locations
# devtools::load_all('.')
# devtools::load_all("~/moiR")
# require(ggplot2)
# require(cowplot)
# require(RColorBrewer)
# require(dplyr)
#
# # rall<-raster('data-raw/terraclimate.gri')
#
# source("~/mexposito/moiR/R/worldmap.R")
# load("data/acc515.rda")
# load("data/euroacc.rda")
#
# env<-overlapbio(lon=fn(acc515$longitude),lat= fn(acc515$latitude),
#                 rast=r)
# head(env)
#
# env_<-data.frame(env)
# # env_$SD<-apply(env_,1,function(i) sd(i) )
# env_$CV<-apply(env_,1,function(i) sd(i) /mean(i))
# # env_$DIFF<-apply(env_,1,function(i) mean(diff(i)) /mean(i))
# dim(env_)
#
# env[1,] %>% plot(type="lines")
#
#
# tosave<-dplyr::select(env_,CV)
# colnames(tosave)<-paste0("CV",variableclim)
# saveRDS(file = paste0('dataint/','acc515temporalenv.rda'),tosave)
#
# ##### Plot in map
# # ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
# #             env_[euroacc,"SD"]) %>%
#             # nolegendgg()
# ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
#             env_[euroacc,"CV"]) %>%
#             nolegendgg()
# # ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
# #             env_[euroacc,"DIFF"]) %>%
# #             nolegendgg()
#
# mymap<-ggplot_world_map(xlim = broadeuroextents()$xlim, ylim=broadeuroextents()$ylim)
# p<-mymap+geom_point(aes(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
#                      color=env_[euroacc,"CV"] ))+
#   scale_color_gradientn(colors=brewer.pal(5,"RdBu"))
#
# save_plot(filename = "figs/temporal_climate_variation.pdf",p, base_height =  4,base_width = 12)


#
# #####**********************************************************************#####
# #### Download data ####
#
# start<-1958
# end<-2017
#
# seq(start,end,by=5)
#
# i<-start
#
# # for(i in seq(start,end,by=1)){
# #   cmd<-paste0('wget https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate_ppt_',i,'.nc &')
# #   system(cmd)
# # }
#
# # for(i in seq(start,end,by=1)){
# #   cmd<-paste0('wget https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate_tmax_',i,'.nc &')
# #   system(cmd)
# # }
#
# #### Read data ####
# variableclim="tmax"
# variableclim="ppt"
#
# library(raster)
# # terrafiles<-list.files(path = "data-raw/",pattern = "TerraClimate_ppt_",full.names = T)
# # terrafiles<-list.files(path = "data-raw/",pattern = "TerraClimate_tmax_",full.names = T)
# terrafiles<-list.files(path = "data-raw/",pattern = paste0("TerraClimate_",variableclim),full.names = T)
#
# # mytimes<-gsub("data-raw//TerraClimate_ppt_","",terrafiles)
# # mytimes<-gsub("data-raw//TerraClimate_tmax_","",terrafiles)
# mytimes<-gsub(paste0("data-raw//TerraClimate_",variableclim,"_"),"",terrafiles)
# mytimes<-gsub(".nc","",mytimes)
#
# # rasterexample=raster(terrafiles[1],band=1,ncdf=TRUE)
# # rasterexample=raster(terrafiles[1],level=2,ncdf=TRUE)
# # rasterexample
# # baseras<-makebaseraster()
# # crs(rasterexample) <- baseras@crs
# #
# # stackexample=lapply(1:12, function(i) raster(terrafiles[1],band=i,ncdf=TRUE))
# # stackexample=stack(stackexample)
# # crs(stackexample) <- baseras@crs
# # stackexample<-sum(stackexample)
#
# source("R/gem.R")
# source("R/euroextents.R")
# require(raster)
#
# baseras<-makebaseraster()
#
# rall = lapply(terrafiles,function(myr) {
#   message(myr)
#   rtmp=stack(lapply(1:12, function(i) raster(myr,band=i,ncdf=TRUE)))
#   crs(rtmp) <- baseras@crs
#   r<-cropenvironment(rtmp,xlim = broadeuroextents()$xlim,ylim=broadeuroextents()$ylim)
#   r<-sum(r)
#   return(r)
# })
#
# rall
# rall_ = stack(rall)
# names(rall_)
# names(rall_)<-paste0(variableclim,mytimes)
#
# raster::writeRaster(rall_,filename = paste0("data-raw/terraclimate-",variableclim), overwrite=T)
#
#
# r<-rall_
#
# #####**********************************************************************#####
# #### Read again ####
# r<-raster(paste0("data-raw/terraclimate-",variableclim,'.grd'))
#
# #####**********************************************************************#####
# ##### Extract locations
# # devtools::load_all('.')
# devtools::load_all("~/moiR")
# require(ggplot2)
# require(cowplot)
# require(RColorBrewer)
# require(dplyr)
#
# # rall<-raster('data-raw/terraclimate.gri')
#
# source("~/mexposito/moiR/R/worldmap.R")
# load("data/acc515.rda")
# load("data/euroacc.rda")
#
# env<-overlapbio(lon=fn(acc515$longitude),lat= fn(acc515$latitude),
#                 rast=r)
# head(env)
#
# env_<-data.frame(env)
# # env_$SD<-apply(env_,1,function(i) sd(i) )
# env_$CV<-apply(env_,1,function(i) sd(i) /mean(i))
# # env_$DIFF<-apply(env_,1,function(i) mean(diff(i)) /mean(i))
# dim(env_)
#
# env[1,] %>% plot(type="lines")
#
#
# tosave<-dplyr::select(env_,CV)
# colnames(tosave)<-paste0("CV",variableclim)
# saveRDS(file = paste0('dataint/','acc515temporalenv.rda'),tosave)
#
# ##### Plot in map
# # ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
# #             env_[euroacc,"SD"]) %>%
#             # nolegendgg()
# ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
#             env_[euroacc,"CV"]) %>%
#             nolegendgg()
# # ggdotscolor(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
# #             env_[euroacc,"DIFF"]) %>%
# #             nolegendgg()
#
# mymap<-ggplot_world_map(xlim = broadeuroextents()$xlim, ylim=broadeuroextents()$ylim)
# p<-mymap+geom_point(aes(x=fn(acc515$longitude)[euroacc],y= fn(acc515$latitude)[euroacc],
#                      color=env_[euroacc,"CV"] ))+
#   scale_color_gradientn(colors=brewer.pal(5,"RdBu"))
#
# save_plot(filename = "figs/temporal_climate_variation.pdf",p, base_height =  4,base_width = 12)
