##
# Interactive map for SPECTRE group
# Chris Griffiths
# 13th March 2021
# Base stuff taken from https://www.earthdatascience.org/courses/earth-analytics/spatial-data-r/make-interactive-maps-with-leaflet-r/

##
# load libraries
library(dplyr)
library(rgdal)
library(ggplot2)
library(leaflet)

##
# set factors to false
options(stringsAsFactors = FALSE)

##
# setwd
setwd("~/Desktop")

##
# load data
dat = read.csv('SPECTRE_group (Responses).csv')
# rename columns
colnames(dat) = c('time', 'name', 'where','region','map','website', 'slack', 'city', 'country', 'lat', 'lon')

##
# data manipulation
# remove individuals that don't want to be on the map (n = 2)
dat = filter(dat, map == 'Yes')

# jitter locations so that individual markers don't overlap
dat$lat = jitter(dat$lat, factor = 10)
dat$lon = jitter(dat$lon, factor = 10)

# manually deal with a few name/place issues
dat$name[5] = 'Carmen García-Comas'
dat$name[11] = 'Daniel Pérez'
dat$name[42] = 'Jorge Juan Montes-Pérez'
dat$name[71] = 'Anna Gårdmark'
dat$city[11] = 'Bogotá'
dat$city[19] = 'Concepción'
dat$city[66] = 'Taiwan'

##
# make map 
site_locations <- leaflet(dat) %>% # used leaflet to plot
  addProviderTiles("Esri.WorldImagery") %>% # choose map - there are numerous options
  addMarkers(lng = ~lon, lat = ~lat, # add markers based on long and lats
             popup = paste("<a href=",dat$website,'>',dat$name,'</a>', "<br>", 
                                                   dat$city, "<br>",
                                                   dat$country)) # add pop-up info. I've opted to make name a hyperlink to website - this can be easily changed

# plot in R window
site_locations

# to export, I've used the R Studio 'Export>Save as a Web Page' to export
