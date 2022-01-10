setwd("d:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/")
getwd()

library(tidyverse)

# read all processed files:
# enade_data: rename col 1
enade_data = read.csv("01a_enade_2019_summary_mean_grade_by_citie.csv")
enade_data = enade_data %>%
  rename("cod_municipio_ibge" = 1)
# anatel_data:
anatel_data = read.csv("01c_anatel_internet_access_processed.csv")
# pnad wage data:
pnad_wage_data = read.csv("01b_pnad_mean_sd_uf.csv")

# Merge Data
# left join Enade and Anatel Data:
enade_anatel = left_join(x = enade_data, y = anatel_data, by="cod_municipio_ibge")
# left join with pnad wage data:
enade_anatel_wage = left_join(x = enade_anatel, y = pnad_wage_data, by="UF")

# Clean repeated variable names:
processed_data = enade_anatel_wage %>%
  select(-X.x, -municipio, -X.y) %>%
  data.frame()

# Record Processed Data into CSV for experiments:
write.csv(x = processed_data, file = "processed_data_internet_enem_wage.csv")
