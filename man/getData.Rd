\name{getData}
\alias{getData}
\alias{ccodes}

\title{Get geographic data }

\description{
Get global geographic data. Data are read from files that are first downloaded if not present in the indicated path. Function \code{ccodes} returns country names and the ISO codes
}

\usage{
getData(name, download=TRUE, path='', ...)
ccodes()
}

\arguments{
  \item{name}{Data set name, currently supported are 'GADM', 'countries', 'SRTM', 'alt', 'worldclim', and 'worldclim_past'. See Details for more info}
  \item{download}{Logical. If \code{TRUE} data will be downloaded if not locally available}
  \item{path}{Character. Path name indicating where to store the data. Default is the current working directory }
  \item{...}{ Additional required (!) parameters. These are data set specific. See Details}   
}
 
\value{
A spatial object (Raster* or Spatial*)
} 

\details{  
'alt' stands for altitude (elevation); the data were aggregated from SRTM 90 m resolution data between -60 and 60 latitude. 'GADM' is a database of global administrative boundaries. 'worldclim' is a database of global interpolated climate data from 1960-1990 averages, and 'worldclim_past' contains inferred and interpolated climate data from mid-holocene (6,000 years ago) and last glacial maximum (22,000 years ago). 'SRTM' refers to the hole-filled CGIAR-SRTM (90 m resolution). 'countries' has polygons for all countries at a higher resolution than the 'wrld_simpl' data in the maptools pacakge . 

If \code{name} is 'alt' or 'GADM' you must provide a 'country=' argument. Countries are specified by their 3 letter ISO codes. Use getData('ISO3') to see these codes. In the case of GADM you must also provide the level of administrative subdivision (0=country, 1=first level subdivision). In the case of alt you can set 'mask' to FALSE. If it is TRUE values for neighbouring countries are set to NA. For example:

\code{getData('GADM', country='FRA', level=1)}

\code{getData('alt', country='FRA', mask=TRUE)}


If \code{name} is 'SRTM' you must provide 'lon' and 'lat' arguments (longitude and latitude). These should be single numbers somewhere within the SRTM tile that you want.

\code{getData('SRTM', lon=5, lat=45)}

If \code{name='worldclim'} or \code{name='worldclim_past'} you must also provide arguments \code{var}, and a resolution \code{res}. Valid variables names are 'tmin', 'tmax', 'prec' and 'bio'. For 'worldclim_past' you also need to specify the past time, 'lgm' or 'mid', as \code{past="lgm"}. Valid resolutions are 0.5 (not for past climates), 2.5, 5, and 10 (minutes of a degree). In the case of \code{res=0.5}, you must also provide a \code{lon} and \code{lat} argument for a tile; for the lower resolutions global data will be downloaded. In all cases there are 12 (monthly) files for each variable except for 'bio' which contains 19 files.

\code{getData('worldclim', var='tmin', res=0.5, lon=5, lat=45)}

\code{getData('worldclim', var='bio', res=10)}

\code{getData('worldclim_past', var='bio', res=10, past="lgm")}


To get (projected) future climate data (CMIP5), you must provide arguments \code{var} and \code{res} as above. Only resolutions 2.5, 5, and 10 are currently available. In addition, you need to provide \code{model}, \code{rcp} and \code{year}. For example,

\code{getData('CMIP5', var='tmin', res=10, rcp=85, model='AC', year=70)}

function (var, model, rcp, year, res, lon, lat, path, download = TRUE) 

'model' should be one of "AC", "BC", "CC", "CE", "CN", "GF", "GD", "GS", "HD", "HG", "HE", "IN", "IP", "MI", "MR", "MC", "MP", "MG", or  "NO".

'rcp' should be one of 26, 45, 60, or 85.

'year' should be 50 or 70

Not all combinations are available. See www.worldclim.org for details.
}

\references{
\url{http://www.worldclim.org}

\url{http://www.gadm.org}

\url{http://srtm.csi.cgiar.org/}

\url{http://diva-gis.org/gdata}
}




\keyword{ spatial }
