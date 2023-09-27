# SCRIPT + STUDENT INFO  ----------------------------------------------------------
#NOMBRE : PABLO GONZALEZ CASTRO
# EXP : 22189394
# TEMA : HANDS_ON_01


# LOADING LIBS. -----------------------------------------------------------
install.packages (c("tidyverse", "dplyr", "janitor"))
library("dplyr", "janitor")

# LOADING DATA ----------------------------------------------------------
exp_22189394<-jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")


# SHORCUTS ----------------------------------------------------------------
#CLEAN CONSOLE = CRTL + l
# %>% = pipe operator shift + crt + m
# ctr + enter = run line


# GIT COMMANDS ------------------------------------------------------------

# git status = info about a repo
# git commit = Add a comment
# git add . =. Add the current dir to the entire repo
# git push -u origin main = send to the remote repo (Github)


# CLI COMMANDS ------------------------------------------------------------

# pwd = shows current dir
# ls = list terminal 
# mkdir = create a dir 
# cd = change dir 

# BASIC INTRUCTIONS -------------------------------------------------------
isa<-8 # assigning values


# TIDYVERSE COMMANDS ------------------------------------------------------
exp_22189394 %>% glimpse() %>%  View()


# 27 de septiembre --------------------------------------------------------

str (exp_22189394) # get database
df <- exp_22189394$ListaEESSPrecio # get readable table
df %>% glimpse()
df %>%  janitor::clean_names() %>% glimpse()