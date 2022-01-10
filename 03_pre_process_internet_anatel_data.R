setwd("d:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/")
getwd()
library(tidyverse)

# Load Data 
internet_data = read.csv("Acessos_Banda_Larga_Fixa_2019_2020_Colunas.csv", sep = ";")

# Reorganizar a tabela dos dados, com a soma dos acessos por tecnologia
internet_data_pivot = pivot_wider(internet_data,
                    id_cols = c("CÃ³digo.IBGE.MunicÃ.pio", "MunicÃ.pio"),
                    names_from = c("Tecnologia"),
                    values_from = "X2019.12",
                    values_fn=sum)

# Renomear as colunas
internet_data_pivot = internet_data_pivot %>%
  rename(cod_municipio_ibge = 1,
         municipio = 2,
         fibra_optica = 3,
         wifi = 4,
         ethernet =5,
         lte = 6,
         vsatelite = 7,
         wimax = 8,
         plc_eletrico = 9,
         xdsl = 10,
         cable_modem = 11,
         fwa_5g_fixed = 12,
         atm_backbone = 13,
         dth_satelite = 14,
         hfc_tv_cabo = 15,
         fr_frame_relay =16,
         mmds = 17) %>%
  replace_na(list(fibra_optica = 0,
                  wifi = 0,
                  ethernet = 0,
                  lte = 0,
                  vsatelite = 0,
                  wimax = 0,
                  plc_eletrico = 0,
                  xdsl = 0,
                  cable_modem = 0,
                  fwa_5g_fixed = 0,
                  atm_backbone = 0,
                  dth_satelite = 0,
                  hfc_tv_cabo = 0,
                  fr_frame_relay = 0,
                  mmds = 0))

# escrever os dados de acesso a internet em csv:
write.csv(x = internet_data_pivot, file = "01c_anatel_internet_access_processed.csv")
