######################
#### PRONOSTICO DIARIO DE HIELO
##########
# 
# rm(list=ls()) 
# gc()
# anomalias_lista=list()
# #install.packages(c("sf"))
# #si se corre desde un enviroment guardado corer por partes desde aca
# require(data.table)
# require(ggplot2)
# require(dplyr)
# 
# #require(dplyr)
# #library(sf)
# library(pryr)
# require(MASS)
# require(abind)
# require(TSA)
# require(openair) #La columna de la fecha debe llamarse "date"
# require(date)
# require(chron)
# require(maps)
# library(rgdal)
# library(raster)
# require(fields)
# require(maptools)
# require(mapdata)
# require(rgeos)
# require(ggmap)
# require(sp)
# require(metR)
# require(s2dverification)
# #library(PlotSvalbard)
# require(GEOmap)
# require(gdata)
# require(devtools)
# require(reshape2)
# require(ff) #Libreria para mejor rendimiento de memoria
# require(bigmemory) #Libreria para mejor rendimiento de memoria
# #install.packages(c("data.table","ggplot2","dplyr","pryr","MASS","abind","TSA","openair","date","chron","maps","rgdal","raster","fields","maptools","mapdata","rgeos","ggmap","sp","metR","s2dverification","PlotSvalbard","devtools","reshape2","ff","bigmemory"))
# setwd("C:/Proyectos/Hielo_Marino")
# Rprofmem("Rprofmem.out")


# a_diaria_mes0_A <- a_diaria_mes1_A
# diario_mes0_A <- diario_mes1_A
# a_diaria_mes0_C <- a_diaria_mes1_C
# diario_mes0_C <- diario_mes1_C
# a_diaria_mes1_A <- a_diaria_mes2_A
# diario_mes1_A <- diario_mes2_A
# a_diaria_mes1_C <- a_diaria_mes2_A
# diario_mes1_C <- diario_mes2_C
# 
# save(a_diaria_mes0_A,diario_mes0_A,a_diaria_mes0_C,diario_mes0_C,a_diaria_mes1_A,diario_mes1_A,
#      a_diaria_mes1_C,diario_mes1_C,file="back_EFMdiario.RData")







rm(list=ls())
gc()
anomalias_lista=list()
require(data.table)
require(ggplot2)
require(dplyr)
library(pryr)
require(MASS)
require(abind)
require(TSA)
require(openair) #La columna de la fecha debe llamarse "date"
require(date)
require(chron)
require(maps)
library(rgdal)
library(raster)
require(fields)
require(maptools)
require(mapdata)
require(rgeos)
require(ggmap)
require(sp)
require(metR)
require(s2dverification)
#library(PlotSvalbard)
require(gdata)
require(devtools)
require(reshape2)
require(ff) #Libreria para mejor rendimiento de memoria
require(bigmemory) #Libreria para mejor rendimiento de memoria
#install.packages(c("data.table","ggplot2","dplyr","pryr","MASS","abind","TSA","openair","date","chron","maps","rgdal","raster","fields","maptools","mapdata","rgeos","ggmap","sp","metR","s2dverification","PlotSvalbard","devtools","reshape2","ff","bigmemory"))
setwd("C:/Proyectos/Hielo_Marino")
Rprofmem("Rprofmem.out")



















############## BASE DE DATOS #############
datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
lat <- datos_lista[[40]]$Lat #Puede ser 40 u otro cualquiera
lon <- datos_lista[[40]]$Long
area <- datos_lista[[40]]$Area
#media_total <- readRDS("media_total2.rds")
#mensual_lista <- readRDS("mensual_lista2.rds")

##########################################################
############## PARAMETROS A EDITAR #######################
##########################################################





mes0 <- 10
#mes1 <- 
#mes2 <- 
#mes3 <- NULL 
diasmes0 <-31
#diasmes1 <- 31
#diasmes2 <- 28
#diasmes3 <- NULL
#anios = anio-1977 (Posición en datos_lista)

# le saqu? a?os previos al 88 a todo


#anios_mes0_A <- c(9,10,14,18,20,23,23)
# anios_mes0_B <- c(3,4,11,14,15,17,24,28,30,43)
anios_mes0_C <- c(14,17,30,32)
# anios_mes0_D <- c(14,17,18,19,30)

#anios_mes0_E <- NULL


# anios_mes1_A <- c(14,15,17,21,26,39)
# anios_mes1_B <- c(11,21,24,31,32,37,38)
# anios_mes1_C <- c(26,29,30,31,35)
# 



# anios_mes2_A <- c(11,14,15)
# anios_mes2_B <- c(12,23,26,27,33)
# anios_mes2_C <- c(12,16,27,35,37,40,42,43)
# # 
# # anios_mes3_A <- NULL
# anios_mes3_B <- NULL
# anios_mes3_C <- NULL

#########################################################
#########################################################


#### Variables ####
{
  sep_a1 <- vector(mode="numeric",length = 82908)
  # an_sep_a1 <- vector(mode="numeric",length = 82907)
  # sep_a2 <- vector(mode="numeric",length = 82907)
  # an_sep_a2 <- vector(mode="numeric",length = 82907)
  # sep_a3 <- vector(mode="numeric",length = 82907)
  # an_sep_a3 <- vector(mode="numeric",length = 82907)
  # oct_a1 <- vector(mode="numeric",length = 82907)
  # an_oct_a1 <- vector(mode="numeric",length = 82907)
  # oct_a2 <- vector(mode="numeric",length = 82907)
  # an_oct_a2 <- vector(mode="numeric",length = 82907)
  # oct_a3 <- vector(mode="numeric",length = 82907)
  # an_oct_a3 <- vector(mode="numeric",length = 82907)
  # nov_a1 <- vector(mode="numeric",length = 82907)
  # an_nov_a1 <- vector(mode="numeric",length = 82907)
  # nov_a2 <- vector(mode="numeric",length = 82907)
  # an_nov_a2 <- vector(mode="numeric",length = 82907)
  # nov_a3 <- vector(mode="numeric",length = 82907)
  # an_nov_a3 <- vector(mode="numeric",length = 82907)
  # 
  # sep_b1 <- vector(mode="numeric",length = 82907)
  # an_sep_b1 <- vector(mode="numeric",length = 82907)
  # sep_b2 <- vector(mode="numeric",length = 82907)
  # an_sep_b2 <- vector(mode="numeric",length = 82907)
  # sep_b3 <- vector(mode="numeric",length = 82907)
  # an_sep_b3 <- vector(mode="numeric",length = 82907)
  # oct_b1 <- vector(mode="numeric",length = 82907)
  # an_oct_b1 <- vector(mode="numeric",length = 82907)
  # oct_b2 <- vector(mode="numeric",length = 82907)
  # an_oct_b2 <- vector(mode="numeric",length = 82907)
  # oct_b3 <- vector(mode="numeric",length = 82907)
  # an_oct_b3 <- vector(mode="numeric",length = 82907)
  # nov_b1 <- vector(mode="numeric",length = 82907)
  # an_nov_b1 <- vector(mode="numeric",length = 82907)
  # nov_b2 <- vector(mode="numeric",length = 82907)
  # an_nov_b2 <- vector(mode="numeric",length = 82907)
  # nov_b3 <- vector(mode="numeric",length = 82907)
  # an_nov_b3 <- vector(mode="numeric",length = 82907)
  # 
  # sep_c1 <- vector(mode="numeric",length = 82907)
  # an_sep_c1 <- vector(mode="numeric",length = 82907)
  # sep_c2 <- vector(mode="numeric",length = 82907)
  # an_sep_c2 <- vector(mode="numeric",length = 82907)
  # sep_c3 <- vector(mode="numeric",length = 82907)
  # an_sep_c3 <- vector(mode="numeric",length = 82907)
  # oct_c1 <- vector(mode="numeric",length = 82907)
  # an_oct_c1 <- vector(mode="numeric",length = 82907)
  # oct_c2 <- vector(mode="numeric",length = 82907)
  # an_oct_c2 <- vector(mode="numeric",length = 82907)
  # oct_c3 <- vector(mode="numeric",length = 82907)
  # an_oct_c3 <- vector(mode="numeric",length = 82907)
  # nov_c1 <- vector(mode="numeric",length = 82907)
  # an_nov_c1 <- vector(mode="numeric",length = 82907)
  # nov_c2 <- vector(mode="numeric",length = 82907)
  # an_nov_c2 <- vector(mode="numeric",length = 82907)
  # nov_c3 <- vector(mode="numeric",length = 82907)
  # an_nov_c3 <- vector(mode="numeric",length = 82907)
  # 
  # dic_a1 <- vector(mode="numeric",length = 82907)
  # an_dic_a1 <- vector(mode="numeric",length = 82907)
  # dic_a2 <- vector(mode="numeric",length = 82907)
  # an_dic_a2 <- vector(mode="numeric",length = 82907)
  # dic_a3 <- vector(mode="numeric",length = 82907)
  # an_dic_a3 <- vector(mode="numeric",length = 82907)
  # dic_b1 <- vector(mode="numeric",length = 82907)
  # an_dic_b1 <- vector(mode="numeric",length = 82907)
  # dic_b2 <- vector(mode="numeric",length = 82907)
  # an_dic_b2 <- vector(mode="numeric",length = 82907)
  # dic_b3 <- vector(mode="numeric",length = 82907)
  # an_dic_b3 <- vector(mode="numeric",length = 82907)
  # dic_c1 <- vector(mode="numeric",length = 82907)
  # an_dic_c1 <- vector(mode="numeric",length = 82907)
  # dic_c2 <- vector(mode="numeric",length = 82907)
  # an_dic_c2 <- vector(mode="numeric",length = 82907)
  # dic_c3 <- vector(mode="numeric",length = 82907)
  # an_dic_c3 <- vector(mode="numeric",length = 82907)
}
#Cambiar nombre del archivo donde se va guardando el environment

#### MES 0 ####

# PATRON A #
rm(datos_lista)
anios_patron <- anios_mes0_A
sep_a1 <- NULL
for (i in anios_patron) {          
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20_b.rds")
  } else if (i>35){
     datos_lista <- readRDS("datos_diarios_lista3_36_45.rds")
  } else {
     datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)])) #Saco lat lon y area
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i) 
  t9a_1 <- selectByDate(tmp,month = mes0)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes0+2]
}

diarios_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907) # 82907 son la cantidad de datos por dia filtrados de 104912
a_diaria_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
for (i in 1:diasmes0){
  diarios_mes0[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1]) #le saco date
  #a_diaria_mes0[i,] <- diarios_mes0[i,] - media_total[,mes0+2]   # ANOMALIA DESACTIVADA
}
diario_mes0_A <- cbind(lat,lon,t(as.data.table(diarios_mes0))) #dias en columnas
#a_diaria_mes0_A <- cbind(lat,lon,t(as.data.table(a_diaria_mes0))) #ANOMALIA DESACTIVADA

testigo <- "Mes 0A finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)
Sys.time()  

# 
anios_patron <- anios_mes0_B
sep_a1 <- NULL
for (i in anios_patron) {
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20_b.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_45.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)

  print(i)
  t9a_1 <- selectByDate(tmp,month = mes0)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes0+2]
}

diarios_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
a_diaria_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
for (i in 1:diasmes0){
  diarios_mes0[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  # a_diaria_mes0[i,] <- diarios_mes0[i,] - media_total[,mes0+2]
}
diario_mes0_B <- cbind(lat,lon,t(as.data.table(diarios_mes0))) #dias en columnas
# a_diaria_mes0_B <- cbind(lat,lon,t(as.data.table(a_diaria_mes0)))

testigo <- "Mes 0B finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)
Sys.time()

#############
anios_patron <- anios_mes0_C
sep_a1 <- NULL
for (i in anios_patron) {
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20_b.rds")
    
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_45.rds")
   
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
    
  }
 
  
  ##########
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)

  print(i)
  t9a_1 <- selectByDate(tmp,month = mes0)
  sep_a1 <- rbind(sep_a1,t9a_1) # junta los datos de cada dia del patron, es decir en misma matriz
  #todos los a?os del patron todos los dias, uno debajo del otro
  # a9a_1 <- t9a_1-media_total[,mes0+2]
}

diarios_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
# a_diaria_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
for (i in 1:diasmes0){
  diarios_mes0[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  # a_diaria_mes0[i,] <- diarios_mes0[i,] - media_total[,mes0+2]
}
diario_mes0_C <- cbind(lat,lon,t(as.data.table(diarios_mes0))) #dias en columnas
# a_diaria_mes0_C <- cbind(lat,lon,t(as.data.table(a_diaria_mes0)))

testigo <- "Mes 0C finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)
Sys.time()


anios_patron <- anios_mes0_D
sep_a1 <- NULL
for (i in anios_patron) {          
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20_b.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_45.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes0)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes0+2]
}
diarios_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
a_diaria_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
for (i in 1:diasmes0){
  diarios_mes0[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  # a_diaria_mes0[i,] <- diarios_mes0[i,] - media_total[,mes0+2]
}
diario_mes0_D <- cbind(lat,lon,t(as.data.table(diarios_mes0))) #dias en columnas
# a_diaria_mes0_D <- cbind(lat,lon,t(as.data.table(a_diaria_mes0)))

testigo <- "Mes 0D finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)
Sys.time() 

anios_patron <- anios_mes0_E
sep_a1 <- NULL
for (i in anios_patron) {          
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20_b.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_45.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes0)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes0+2]
}
diarios_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
#a_diaria_mes0 <- matrix(NA,nrow = diasmes0,ncol = 82907)
for (i in 1:diasmes0){
  diarios_mes0[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  #a_diaria_mes0[i,] <- diarios_mes0[i,] - media_total[,mes0+2]
}
diario_mes0_E <- cbind(lat,lon,t(as.data.table(diarios_mes0))) #dias en columnas
#a_diaria_mes0_E <- cbind(lat,lon,t(as.data.table(a_diaria_mes0)))

testigo <- "Mes 0E finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)
print("Listo para graficar")


##### MES 1 ####

anios_patron <- anios_mes1_A
sep_a1 <- NULL
for (i in anios_patron) {       
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes1)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes1+2]
}

diarios_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
#a_diaria_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
for (i in 1:diasmes1){
  diarios_mes1[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  #a_diaria_mes1[i,] <- diarios_mes1[i,] - media_total[,mes1+2]
}
diario_mes1_A <- cbind(lat,lon,t(as.data.table(diarios_mes1))) #dias en columnas
#a_diaria_mes1_A <- cbind(lat,lon,t(as.data.table(a_diaria_mes1)))

testigo <- "Mes 1A finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)

anios_patron <- anios_mes1_B
sep_a1 <- NULL
for (i in anios_patron) {       
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes1)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes1+2]
}

diarios_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
#a_diaria_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
for (i in 1:diasmes1){
  diarios_mes1[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
 # a_diaria_mes1[i,] <- diarios_mes1[i,] - media_total[,mes1+2]
}
diario_mes1_B <- cbind(lat,lon,t(as.data.table(diarios_mes1))) #dias en columnas
#a_diaria_mes1_B <- cbind(lat,lon,t(as.data.table(a_diaria_mes1)))

testigo <- "Mes 1B finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)

anios_patron <- anios_mes1_C
sep_a1 <- NULL
for (i in anios_patron) {  
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes1)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes1+2]
}

diarios_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
#a_diaria_mes1 <- matrix(NA,nrow = diasmes1,ncol = 82907)
for (i in 1:diasmes1){
  diarios_mes1[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
 # a_diaria_mes1[i,] <- diarios_mes1[i,] - media_total[,mes1+2]
}
diario_mes1_C <- cbind(lat,lon,t(as.data.table(diarios_mes1))) #dias en columnas
#a_diaria_mes1_C <- cbind(lat,lon,t(as.data.table(a_diaria_mes1)))

testigo <- "Mes 1C finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)

#### MES 2 ####

anios_patron <- anios_mes2_A
sep_a1 <- NULL
for (i in anios_patron) { 
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes2)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes2+2]
}

diarios_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
#a_diaria_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
for (i in 1:diasmes2){
  diarios_mes2[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  #a_diaria_mes2[i,] <- diarios_mes2[i,] - media_total[,mes2+2]
}
diario_mes2_A <- cbind(lat,lon,t(as.data.table(diarios_mes2))) #dias en columnas
#a_diaria_mes2_A <- cbind(lat,lon,t(as.data.table(a_diaria_mes2)))

testigo <- "Mes 2A finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)


anios_patron <- anios_mes2_B
sep_a1 <- NULL
for (i in anios_patron) {        
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes2)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes2+2]
}
diarios_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
#a_diaria_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
for (i in 1:diasmes2){
  diarios_mes2[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
  #a_diaria_mes2[i,] <- diarios_mes2[i,] - media_total[,mes2+2]
}
diario_mes2_B <- cbind(lat,lon,t(as.data.table(diarios_mes2))) #dias en columnas
#a_diaria_mes2_B <- cbind(lat,lon,t(as.data.table(a_diaria_mes2)))

testigo <- "Mes 2B finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)


anios_patron <- anios_mes2_C
sep_a1 <- NULL
for (i in anios_patron) {        
  print(Sys.time())
  ########### Leo datos segun los años  (optimiza uso de disco)
  if (i<21){
    datos_lista <- readRDS("datos_diarios_lista3_1_20.rds")
  } else if (i>35){
    datos_lista <- readRDS("datos_diarios_lista3_36_44.rds")
  } else {
    datos_lista <- readRDS("datos_diarios_lista3_21_35.rds")
  }
  ##########  
  tmp <- as.data.frame(t(datos_lista[[i]][,-c(1:3)]))
  tmp <- as.data.table(cbind(as.Date(row.names(tmp)),tmp))
  colnames(tmp)[1] <- "date"
  rm(datos_lista)
  
  print(i)
  t9a_1 <- selectByDate(tmp,month = mes2)
  sep_a1 <- rbind(sep_a1,t9a_1)
  # a9a_1 <- t9a_1-media_total[,mes2+2]
}
diarios_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
#a_diaria_mes2 <- matrix(NA,nrow = diasmes2,ncol = 82907)
for (i in 1:diasmes2){
  diarios_mes2[i,] <- colMeans(selectByDate(data.table(sep_a1), day= i)[,-1])
 # a_diaria_mes2[i,] <- diarios_mes2[i,] - media_total[,mes2+2]
}
diario_mes2_C <- cbind(lat,lon,t(as.data.table(diarios_mes2))) #dias en columnas
#a_diaria_mes2_C <- cbind(lat,lon,t(as.data.table(a_diaria_mes2)))

testigo <- "Mes 2C finalizado"
save.image("C:/Proyectos/Hielo_Marino/environment_DIARIO.RData")
print(testigo)








#################################################################################
############################# Armado de campos ##################################
#################################################################################


### Si hay problemas se puede explorar cada factor con head(as.matrix(diario_mes0_D[,-c(1,2)]))
#Los a?os anteriores al 88 suelen dar problemas 
# MES 0

#Prono_mes0 <- (1*as.matrix(diario_mes0_A[,-c(1,2)]))
          
                 
Prono_mes0 <- (0.5*as.matrix(diario_mes0_A[,-c(1,2)])+
              0.5*as.matrix(diario_mes0_B[,-c(1,2)]))
  
#Prono_mes0 <- (0.5*as.matrix(diario_mes0_A[,-c(1,2)])+
#                   0.25*as.matrix(diario_mes0_B[,-c(1,2)])+
#                  0.25*as.matrix(diario_mes0_C[,-c(1,2)]))
# # #
# 
#Prono_mes0 <- (0.15*as.matrix(diario_mes0_A[,-c(1,2)])+
#                   0.15*as.matrix(diario_mes0_B[,-c(1,2)])+
#                    0.4*as.matrix(diario_mes0_C[,-c(1,2)])+
#                   0.3*as.matrix(diario_mes0_D[,-c(1,2)]))#


# 
# Exportar_txt <- "si"
# 
# if (Exportar_txt=="si"){
# 
#   tmp0 <- cbind(lat,lon,area,Prono_mes0)
# 
#   write.fwf(round(tmp0,4),paste("SHN_","ENE22","concentracion.txt"),sep = " ",quote = F,rownames = F,width = 14)
# }

Prono_mes0 <- cbind(lat, lon, Prono_mes0)

areas_prono_mes0 <- Prono_mes0[,-c(1,2)]*area/100 # PARA GRAFICAR SOLO CONCENTRACIÓN, SIN *AREA
sum_areas_mes0 <- colSums(areas_prono_mes0,dims = 1)

# 
# Exportar_txt <- "si" # "si" #SELECCIONO SI QUIERO EXPORTAR LOS TXT DIARIOS
# # 
#  if (Exportar_txt=="si"){
#    for (dia in 1:diasmes0){
#      tmp0 <- cbind(lat,lon,area,Prono_mes0[,dia+2])
#      write.fwf(round(tmp0,4),paste("SHN_feb_23",dia,"concentracion_nuevo_B.txt"),sep = " ",quote = F,rownames = F,width = 14)
#    }
#   }

  
# 
# # MES 1
# 
# Prono_mes1 <- (0.4*as.matrix(diario_mes1_A[,-c(1,2)])+   # -c saca las solumnas 1 y 2 que son las lon y lat
#                  0.3*as.matrix(diario_mes1_B[,-c(1,2)])+
#                  0.3*as.matrix(diario_mes1_C[,-c(1,2)]))
# # 
#  Prono_mes1 <- (0.65*as.matrix(diario_mes1_A[,-c(1,2)])+   # -c saca las solumnas 1 y 2 que son las lon y lat
# #                  0.35*as.matrix(diario_mes1_B[,-c(1,2)]))
# # 
# 
# Prono_mes1 <- (0.4*as.matrix(diario_mes1_A[,-c(1,2)])+
#                   0.3*as.matrix(diario_mes1_B[,-c(1,2)])+
#                   0.3*as.matrix(diario_mes1_C[,-c(1,2)]))
# # 
# 
# Exportar_txt <- "si"
# 
# if (Exportar_txt=="si"){
#   
#   tmp0 <- cbind(lat,lon,area,Prono_mes1)
#   
#   write.fwf(round(tmp0,4),paste("SHN_","ENE22_C3","concentracion.txt"),sep = " ",quote = F,rownames = F,width = 14)
# }
# 
# Prono_mes1 <- cbind(lat, lon, Prono_mes1)
# 
# areas_prono_mes1 <- Prono_mes1[,-c(1,2)]*area/100 # PARA GRAFICAR SOLO CONCENTRACIÓN, SIN *AREA
# sum_areas_mes1 <- colSums(areas_prono_mes1,dims = 1)
# 
# Exportar_txt <- "si" # "si" #SELECCIONO SI QUIERO EXPORTAR LOS TXT DIARIOS
# 
# if (Exportar_txt=="si"){
#   for (dia in 1:diasmes1){
#     tmp0 <- cbind(lat,lon,area,Prono_mes1[,dia+2])
#     write.fwf(round(tmp0,4),paste("SHN_",dia+31,"junio22.txt"),sep = " ",quote = F,rownames = F,width = 14)
#   }
# }
# # 
# # MES 2
# # Prono_mes2 <- (0.4*diario_mes2_A[,-c(1,2)]+0.4*diario_mes2_B[,-c(1,2)]
# #                +0.2*diario_mes2_C[,-c(1,2)])
# 
# Prono_mes2 <- (0.65*as.matrix(diario_mes2_A[,-c(1,2)])+   # -c saca las solumnas 1 y 2 que son las lon y lat
#                  0.35*as.matrix(diario_mes2_B[,-c(1,2)]))

#Prono_mes2 <- (0.345*as.matrix(diario_mes2_A[,-c(1,2)])+   # -c saca las solumnas 1 y 2 que son las lon y lat
 #                 0.423*as.matrix(diario_mes2_B[,-c(1,2)])+
  #                0.26*as.matrix(diario_mes2_C[,-c(1,2)]))
# 
# Exportar_txt <- "si"
# 
# if (Exportar_txt=="si"){
#   
#   tmp0 <- cbind(lat,lon,area,Prono_mes2)
#   
#   write.fwf(round(tmp0,4),paste("SHN_","FEB22_c3","concentracion.txt"),sep = " ",quote = F,rownames = F,width = 14)
# }
# 

# Prono_mes2 <- cbind(lat, lon, Prono_mes2)
# 
# areas_prono_mes2 <- Prono_mes2[,-c(1,2)]*area/100 # PARA GRAFICAR SOLO CONCENTRACIÓN, SIN *AREA
# sum_areas_mes2 <- colSums(areas_prono_mes2,dims = 1)
# 
# Exportar_txt <- "si" # "si" #SELECCIONO SI QUIERO EXPORTAR LOS TXT DIARIOS
# 
# if (Exportar_txt=="si"){
#   for (dia in 1:diasmes2){
#     tmp0 <- cbind(lat,lon,area,Prono_mes2[,dia+2])
#     write.fwf(round(tmp0,4),paste("SHN_",dia+62,"Julio22.txt"),sep = " ",quote = F,rownames = F,width = 14)
#   }
# }
# # 
# 



########## GRAFICADO #############
### CARGO MAPA ###
# world <- map_data("world2")
# antartida <- world
# # antartida <- world[world$region=="Antarctica",]
# antartida$lon <- antartida$long
# antartida <- antartida[,c("lat","lon","subregion")]
# antartida[,c(4:14)] <- NA
# antartida$subregion <- 1
# antartida[,15] <- antartida$subregion
##########

worldd <- map_data("world2")
worldd <- subset(world, lat < 0)
geom_world <- geom_path(aes(long, lat, group = group), data = worldd, 
                        color = "gray50", size = 0.5)



Graficar <- function(mes,titulo=""){
  #MES es el valor de concentracion
  datap <- as.data.table(mes)
  datap$lat <- round(datap$lat,2) #REDONDEO LAT Y LON
  datap$lon <- round(datap$lon,2)
  colnames(datap)[3] <- "mes"
  datap <- datap[abs(mes)>15]#Saco los ceros
  datap[abs(mes)>100,3] <- 100
  # datap <- rbind(datap,antartida[,c("lat","lon")],fill=TRUE) #AGREGO EL BORDE DE LA ANTARTIDA
  
  ggplot(datap, aes(x=lon, y=lat,color=mes/10))+  #MES es el valor de concentracion
    # geom_point(aes(x=lon,y=lat),size=1,na.rm=T)+
    geom_point(size=0.7)+
    geom_world+
    
    scale_color_gradientn(name="",breaks=seq(1,10,by=1),limits=c(1,10) ,
                          colours = c("white","#8CFFA0","#8CFFA0","#8CFFA0","#FFFF00","#FFFF00","#FFFF00"
                                      ,"#FF7D07","#FF7D07","#FF0000","#FF0000"))+
    
    
    
    # scale_color_gradientn(name="",breaks=seq(1,10,by=1),limits=c(1,10) ,
    #                       colours = c("#8CFFA0","#90DEB4","#D7EE6E","#FFFF00","#FFC800", "#FFAE00", "#FF6F00",
    #                                   "#FF5100","#FF3700","#FF0000"),
    #                       position="bottom")+
    
    
    
    scale_x_longitude(ticks = 60) +
    scale_y_latitude(limits = c(-90, -50),breaks = c(-60,-50),labels = NULL) +
    labs(title=paste("Pron?stico de Concentraci?n de Hielo Marino (en d?cimos)", sep="" ),subtitle =paste(titulo, "- SHN", "- Argentina" ))+
    
    
    coord_polar()+
    theme_minimal()+
    theme(plot.background = element_rect(colour = "white"),
          panel.grid = element_line(colour = "grey"),
          
          # legend.position = "bottom",legend.box.just = "bottom",
          legend.key.width = unit(0.7,"cm"),
          legend.key.height = unit(3,"cm"))+
    geom_text(data = data.frame(x = 0, y = c(-60,-50)), aes(x = x, y = y, label = c("60?S","50?S")),
              inherit.aes = F,size=4)
  
}




#mes <-as.data.frame(media_sep_A) # SET
# Graficar_weddell <- function(mes,titulo=""){
#   datap <- as.data.table(mes)
#   datap$lat <- round(datap$lat,2) #REDONDEO LAT Y LON
#   datap$lon <- round(datap$lon,2)
#   colnames(datap)[3] <- "mes"
#   datap <- datap[abs(mes)>5,] #Saco los ceros
#   # datap <- rbind(datap,antartida[,c("lat","lon")],fill=TRUE) #AGREGO EL BORDE DE LA ANTARTIDA
#   
#   ggplot(datap, aes(x=lon, y=lat,color=mes/10))+
#     # geom_point(aes(x=lon,y=lat),size=1,na.rm=T)+
#     geom_point(size=4)+
#     geom_world+
#     
#     scale_color_gradientn(name="",breaks=seq(0.1,1,by=0.1),limits=c(0,1) ,
#                           colours = c("white","#8CFFA0","#FFFF00","#FF7D07","#FF0000"),
#                           position="bottom")+
#     scale_x_longitude(ticks = 20, limits=c(360-75,360-10)) +
#     scale_y_latitude(limits = c(-90, -50),breaks = c(-60,-50),labels = NULL) +
#     labs(title=paste("holaPronóstico de Concentración de Hielo Marino (en décimos)",sep=""),subtitle =titulo )+
#     # coord_polar()+
#     theme_minimal()+
#     theme(plot.background = element_rect(colour = "white"),
#           panel.grid = element_line(colour = "grey"),
#           legend.position = "bottom",legend.box.just = "bottom",legend.key.width = unit(3,"cm"),
#           legend.key.height = unit(0.7,"cm"))+
#     geom_text(data = data.frame(x = 0, y = c(-60,-50)), aes(x = x, y = y, label = c("60°S","50°S")),
#               inherit.aes = F,size=4)
# 
# }



###############################################################################
############################### PARA LUDMI ####################################
# Graficar <- function(mes,titulo=""){
#   #MES es el valor de concentracion
#   datap <- as.data.table(mes)
#   datap$lat <- round(datap$lat,2) #REDONDEO LAT Y LON
#   datap$lon <- round(datap$lon,2)
#   colnames(datap)[3] <- "mes"
#   #datap <- datap[abs(mes)>5,] #Saco los ceros #prueba
#   datap <- datap[abs(mes)>30]#Saco los ceros
#   datap[abs(mes)>100,3] <- 100
#   # datap <- rbind(datap,antartida[,c("lat","lon")],fill=TRUE) #AGREGO EL BORDE DE LA ANTARTIDA
#  
#   
#   ggplot(datap, aes(x=lon, y=lat,color=mes/10))+  #MES es el valor de concentracion
#     # geom_point(aes(x=lon,y=lat),size=1,na.rm=T)+
#     #coord_map()+
#     geom_point(size=4.5)+
#     geom_world+  
#     
#     #geom_polygon(data =worldd , aes(x = long, y = lat, group = group), 
#     #             colour = 'black', size = 1, linetype = 'solid', alpha = 0)+
# 
# 
#     
#     #scale_color_gradientn(name="",breaks=seq(0.1,1,by=0.1),limits=c(0,1) ,
#      #                      colours = c("white","#8CFFA0","#FFFF00","#FF7D07","#FF0000"),
#     #                       position="bottom")+
#     
#     scale_color_gradientn(name="",breaks=seq(1,10,by=1),limits=c(1,10) ,
#                             colours = c("white","#8CFFA0","#8CFFA0","#8CFFA0","#FFFF00","#FFFF00","#FFFF00"
#                                         ,"#FF7D07","#FF7D07","#FF0000","#FF0000"))+
# 
# 
# 
#      #scale_color_gradientn(name="",breaks=seq(1,10,by=1),limits=c(1,10) ,
#      #                       colours = c("#8CFFA0","#90DEB4","#D7EE6E","#FFFF00","#FFC800", "#FFAE00", "#FF6F00",
#      #                                   "#FF5100","#FF3700","#FF0000"),
#      #                       position="bottom")+
# 
# 
# 
#     #scale_x_longitude(ticks = 60) +
#     scale_x_longitude(ticks = 10, limits=c(360-60,360-15)) + #prueba
#     
#     scale_y_latitude(ticks = 5, limits = c(-80, -60)) +
#     #labs(title=paste("Pron?stico de Concentraci?n de Hielo Marino (en d?cimos)", sep="" ),subtitle =paste(titulo, "- SHN", "- Argentina" ))+
# 
# 
#     #coord_polar()+
#     theme_minimal()+
#           theme(plot.background = element_rect(colour = "white"),
#            panel.grid = element_line(colour = "gray50"),
#            panel.ontop = TRUE, panel.background = element_rect(color = NA, fill = "NA"))+
#            
#            #legend.position = "bottom",legend.box.just = "bottom",
#            # legend.key.width = unit(0.7,"cm"),
#            # legend.key.height = unit(3,"cm"))+
#     theme(legend.position='none')
#     #geom_text(data = data.frame(x = 0, y = c(-70,-60)), aes(x = x, y = y, label = c("60?S","50?S")),
#      #          inherit.aes = F,size=4)
#     
# }
###############################################################################
###############################################################################


# Graficar_anom <- function(mes,titulo=""){
#   datap <- as.data.table(mes)
#   datap$lat <- round(datap$lat,2) #REDONDEO LAT Y LON
#   datap$lon <- round(datap$lon,2)
#   colnames(datap)[3] <- "mes"
#   datap <- datap[abs(mes)>5,] #Saco los ceros
#   # datap <- rbind(datap,antartida[,c("lat","lon")],fill=TRUE) #AGREGO EL BORDE DE LA ANTARTIDA
# 
#   ggplot(datap, aes(x=lon, y=lat,color=mes/10))+ geom_point(aes(x=lon,y=lat),size=0.3,na.rm=T)+ geom_world+
#     # scale_colour_gradient2(name="",limits=c(-100,100),
#     #                       breaks=seq(-100,100,by=25) ,
#     #                       low = "blue",mid = "white",high = "red",
#     #                       position="bottom")+
#     scale_color_gradientn(name="",limits=c(-1,1),breaks=seq(-1,1,by=0.25),
#                           colours = c("darkblue","blue","white","red","darkred"))+
#     scale_x_longitude(ticks = 60) +
#     scale_y_latitude(limits = c(-90, -50),breaks = c(-60,-50),labels = NULL) +
#     labs(title=paste("Pronóstico de Anomalías de Concentración de Hielo Marino \n(en décimos)"),subtitle = titulo)+
#     coord_polar()+
#     theme_minimal()+
#     theme(plot.background = element_rect(colour = "white"),
#           panel.grid = element_line(colour = "grey"),
#           legend.position = "bottom",legend.box.just = "bottom",legend.key.width = unit(3,"cm"),
#           legend.key.height = unit(0.5,"cm"))+
#     geom_text(data = data.frame(x = 0, y = c(-60,-50)), aes(x = x, y = y, label = c("60°S","50°S")),
#               inherit.aes = F,size=4)
# 
#}





#### Graficos #### Cambiar parametros a graficar 
pronostico <- Prono_mes0 # es la concentracion 
tit <- "de octubre 2023"
nombre <- "oct2023.png" #3 letras del mes en castellano, siempre este formato


dia=1
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia) #Tomo columnas lat, lon y el dia
dev.off()



dia=2
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=3
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=4
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=5
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=6
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=7
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=8
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=9
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=10
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=11
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=12
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=13
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=14
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=15
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=16
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=17
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=18
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=19
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=20
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=21
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=22
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=23
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=24
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=25
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=26
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=27
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=28
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=29
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=30
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()

dia=31
fecha <- as.character(dia)  
titdia <- paste(fecha,tit, sep=" ") # ESCRIBIR EL MES
png(paste(fecha,nombre,sep="_"),width =1800,height = 1800, res = 250)
Graficar(pronostico[,c(1,2,dia+2)], titdia)
dev.off()
#####


