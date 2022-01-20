setwd("D:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/3 ibge_pib_idh_gini/")
getwd()
library(tidyverse)

test = read.csv("pib_municipios_ibge_editado_excell.csv", sep = ";", encoding = "UTF-8")
