setwd("D:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/3 ibge_pib_idh_gini/")
getwd()
library(tidyverse)
# load data
idh = read.csv(file = "data_idh_atlas_brasil.csv", sep = ";", dec = ",", encoding = "UTF-8")[, c(1,3)]

idh = idh %>%
  rename("municipios" = 1,
         "idhm" = 2)

write.csv(x = idh, file = "03_idh_processed.csv", row.names = FALSE)
