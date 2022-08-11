library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

# Conexión a la base Shinydemo
MyDB <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

#Se listan las tablas de la base
dbListTables(MyDB)

#Se guardan los datos de CountryLanguage en MyDB
MyDB %>% tbl("CountryLanguage")
DBLangs <- dbGetQuery(MyDB,"Select * from CountryLanguage")
head(DBLangs)

#Se obtienen los paises en los que se habla español y su porcentaje.
DBSpanish <- DBLangs %>% filter(Language == "Spanish")

#Se grafican los porcentajes de cada país
ggplot(DBSpanish,aes(x=Percentage,y=CountryCode, fill=IsOfficial))+
  geom_bin2d()+coord_flip()+
  ggtitle("Paises en los que se habla español")+
  ylab("Paises (código)")+
  xlab("Porcentaje")

