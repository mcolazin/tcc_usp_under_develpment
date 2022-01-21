setwd("D:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/3 ibge_pib_idh_gini/")
getwd()
library(tidyverse)

# read pib data and selected some columns
pib_mun = read.csv("pib_municipios_ibge_editado_excell.csv", sep = ";", encoding = "UTF-8")
pib_mun = pib_mun %>%
  select(cod_mun, municipio, uf, pib, pib_p_capta) %>%
  mutate(pib = recode(pib,
                      "3,54981E+11" = "354981000000",
                      "7,63806E+11" = "763806000000",
                      "2,73614E+11" = "273614000000")) %>%
  data.frame()
# convert pib variable to numeric
pib_mun$pib = as.numeric(pib_mun$pib)
# write processed data
write.csv(x = pib_mun, file = "02_pib_processed.csv", row.names = FALSE)
