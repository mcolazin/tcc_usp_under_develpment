setwd("D:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/3 ibge_pib_idh_gini/")
getwd()
library(tidyverse)

# write csv
table_gini = read.csv2("gini_uf_2019.csv", header = TRUE, quote = '"', sep = ",", encoding = "UTF-8")
table_gini_alter = table_gini %>%
  select(Unidade.da.Federação, gini) %>%
  rename("uf" = 1) %>%
  mutate(uf = recode(uf,
                     "Rondônia" = "RO",
                     "Acre" = "AC",
                     "Amazonas" = "AM",
                     "Roraima" = "RR",
                     "Pará" = "PA",
                     "Amapá" = "AP",
                     "Tocantins" = "TO",
                     "Maranhão" = "MA",
                     "Piauí" = "PI",
                     "Ceará" = "CE",
                     "Rio Grande do Norte" = "RN",
                     "Paraíba" = "PB",
                     "Pernambuco" = "PE",
                     "Alagoas" = "AL",
                     "Sergipe" = "SE",
                     "Bahia" = "BA",
                     "Minas Gerais" = "MG",
                     "Espírito Santo" = "ES",
                     "Rio de Janeiro" = "RJ",
                     "São Paulo" = "SP",
                     "Paraná" = "PR",
                     "Santa Catarina" = "SC",
                     "Rio Grande do Sul" = "RS",
                     "Mato Grosso do Sul" = "MS",
                     "Mato Grosso" = "MT",
                     "Goiás" = "GO",
                     "Distrito Federal" = "DF" ))
# write gini processed
write.csv2(x = table_gini_alter, file = "01_gini_processed.csv", row.names = FALSE)
