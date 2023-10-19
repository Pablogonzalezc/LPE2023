# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: PABLO GONZALEZ CASTRO
# EXP: 22189394
# TEMA: HANDS_ON_01


# LOADING LIBS ------------------------------------------------------------
install.packages (c("tidyverse", "dplyr", "janitor"))
install.packages("openxlsx")
install.packages("leaflet")
install.packages("openxlsx")
library(openxlsx)
library("tidyverse","dplyr","janitor", "jsonlite")
library(tidyverse)
library(leaflet)
library("dplyr","janitor")



# LOADING DATA ------------------------------------------------------------
exp_22189394 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")


# SHORTCUTS ---------------------------------------------------------------

# limpiar consola = CTRL + l
# %>% pipe operator = SHIFT + CTRL + M
# CTRL + ENTER = ejecutar
# SHIFT + CTRL + R = Indice

# GIT COMMANDS ------------------------------------------------------------

# pwd = current location
# git status = info about a repo
# git commit = Add a comment
# git add . = Add the current dir to the entire repo
# git push -u origin main = send to the remote repo (Github)
# %>% para pasar el flijo entre diferentes códigos que voy a utilizar

# CLI COMMANDS ------------------------------------------------------------

# pwd = shows the current dir
# ls = list terminal 
# mkdir = create a dir
# cd = change dir
# clear = limpiar terminal
# set wd 

# BASIC INSTRUCTIONS ------------------------------------------------------

pablo <- 8 # assigning values


# TIDYVERSE COMMANDS ------------------------------------------------------


# 27 SEPTIEMBRE -----------------------------------------------------------

str(exp_22189394) #get datatype
df <- exp_22189394$ListaEESSPrecio #get readable data
df %>% glimpse()
df %>% janitor::clean_names() %>% glimpse()


# WORKING W PIPE (OPT. MODE) ----------------------------------------------
clean_data <- df %>% janitor::clean_names() %>% glimpse()
cd <- df %>% readr::type_convert(locale = readr::locale(decimal_mark=",")) %>% janitor::clean_names()
cd %>% glimpse()


# DEALING W DATA ----------------------------------------------------------

villa_boa_gas <- cd %>% select(precio_gasoleo_a, rotulo, direccion, localidad) %>% 
  filter(rotulo=="BALLENOIL", localidad == "MADRID") %>% 
  arrange(precio_gasoleo_a) %>% View()
Dgas_max <- cd %>% select(precio_gasoleo_a, rotulo, direccion, provincia) %>% filter(provincia == "MADRID") %>% arrange(precio_gasoleo_a) 

gas_mad_ballenoil <- cd %>% select(precio_gasoleo_a, rotulo, direccion, municipio, provincia, c_p) %>% 
  filter(provincia == "MADRID" & rotulo == "BALLENOIL") %>% 
  arrange(precio_gasoleo_a) %>% View()

gas_mad_1_55 <- cd %>% select(precio_gasoleo_a, rotulo, direccion, municipio, provincia,latitud,longitud_wgs84) %>% 
  filter(provincia == "TOLEDO" & precio_gasoleo_a < 1.70) %>% 
  arrange(desc(precio_gasoleo_a))

gas_mad_1_55 %>% leaflet() %>% addTiles() %>% 
  addCircleMarkers(lat = ~latitud,lng = ~longitud_wgs84, popup = ~rotulo, label = ~precio_gasoleo_a)

gasoleo_a_1_55 <- clean_data %>% 
  select(precio_gasoleo_a, rotulo, direccion, provincia, latitud, longitud_wgs84, municipio) %>% 
  filter(provincia=="MADRID" || precio_gasoleo_a<1.50) %>% 
  arrange(desc(precio_gasoleo_a)) %>% write.xlsx("gasole_a_1_55.xls")

cd %>%
  select(precio_gasoleo_a, rotulo, direccion, provincia, latitud, longitud_wgs84, municipio) %>%
  filter(localidad == "MADRID" | precio_gasoleo_a < 1.50) %>% 
  arrange(desc(precio_gasoleo_a)) %>%
  write.xlsx("gasole_a_1_50.xlsx")


average_price <- mean(cd$precio_gasoleo_a, na.rm = TRUE)

cd <- cd %>%
  mutate(is_low_cost = ifelse(precio_gasoleo_a < average_price, "Low Cost", "Not Low Cost"))

View(cd)


# STORING DATA ------------------------------------------------------------
write.xslx(gas_max, "gas_max.csv")
xlsx::write.xlsx(gas_max, "gas_max.xlsx")

openxlsx::write.xlsx(cd, "LowCost.xlsx")

