\name{recursive.getData}
\alias{recursive.getData}


\title{ Get geographic data recursively }

\description{
Call getData function to download recursively all worlclim.org layers.
}

\usage{
recursive.getData(times="all", path='~/', ...)
recursive.getData(times=c("lgm","mid"),var="tmin" )
recursive.getData(times=c("pres","CC8570"),var="bio",res="2.5" )
}
\arguments{
  \item{name}{Vector of time layer(s) desired to be downloaded. Currently "lgm", "mid", "pres", "CC2650", "CC2670", "CC4550", "CC4570", "CC6050", "CC6070", "CC8550", "CC8570". Alternatively specify "all" to download all of them. See Details for more info}
  \item{download}{Logical. If \code{TRUE} data will be downloaded if not locally available}
  \item{path}{Character. Path name indicating where to store the data. Default is the current working directory }
  \item{var}{ Variables to download. Default "bio", but also available "tmin", "tmax", and "prec" }   
  \item{res}{ Resolution of the raster. Default "2.5", also available "5" and "10" }   
}
 
\value{
A spatial object Raster stack or Raster brick
} 

\details{  

}

\references{
\url{https://github.com/MoisesExpositoAlonso/rbioclim}

}

\keyword{ spatial }
