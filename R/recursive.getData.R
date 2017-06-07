# Download recursively geographic data and return as R object
# Author: Moi Exposito-Alonso
# January 2017
#' @export

recursive.getData <- function(times=c("lgm","pres","CC2670","CC8570"),var="bio" ,res="2.5",path="~/"){

designtimes <- list(
    lgm= "worldclim_past",
    mid = "worldclim_past",  
    pres= "worldclim", 
    CC2650="CMIP5",
    CC2670="CMIP5",
    CC4550="CMIP5",
    CC4570="CMIP5",
    CC6050="CMIP5",
    CC6070="CMIP5",
    CC8550="CMIP5",
    CC8570="CMIP5")
  

if( any(times == "all" ) ) { 
  times <-  names(designtimes) 
  }

if( any(!times %in%  names(designtimes) ) ) {
  message("These are the available dataset for recursie download")
  print(names(designtimes))
}
  
sapply( times ,function(dataset) map.getData(dataset,thefun=as.character(designtimes[dataset]),var=var,res=res,path=path) )

  
}

map.getData <- function(dataset,thefun, var,res,path){
message("importing dataset ", dataset)
  if(grepl("CC[0-9][0-9][0-9][0-9]",dataset)){ 
    model=substr(dataset, 1, 2)
    rcp=substr(dataset, 3, 4)
    year=substr(dataset, 5, 6)
    
    tmp<- getData(name =thefun,model=model,rcp=rcp,year=year,
                  download = T,var=var,res=res,path =path)
  } 
  else if(dataset=="pres"){
    tmp<- getData(name =thefun,
            download = T,var=var,res=res,path =path)
  }
  else{
    tmp<- getData(name =thefun,past= dataset,
            download = T,var=var,res=res,path =path)
  }

names(tmp) <- paste0(var,c(1:nlayers(tmp) ))
return(tmp)
}
