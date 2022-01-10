setwd("d:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/")
getwd()

library(PNADcIBGE)
library(tidyverse)

# Carregamento dos dados do Pnad 2019
pnad_2019 = get_pnadc(year = 2019, design = FALSE, interview = 1)

# Dicionário
# - UF - Unidade da Federação
# VD4019 - Rendimento Mensal Efetivo

# Média das Remunerações po UF:
remuneracao_uf_mean_sd = pnad_2019 %>%
  select(VD4019, UF) %>%
  group_by(UF) %>%
  summarise(remuneracao_media = round(mean(VD4019, na.rm = TRUE), digits = 2),
            desvio_padrao = round( sqrt(var(VD4019, na.rm = TRUE)),digits = 2  )) %>%
  data.frame()

# Alterar os dados dos municípios
remuneracao_uf_mean_sd_renamed = remuneracao_uf_mean_sd %>%
  mutate(UF = recode(UF,
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
                     "Distrito Federal" = "DF"))

# Gravar CSV do Pnad processado:
write.csv(remuneracao_uf_mean_sd_renamed, file = "01b_pnad_mean_sd_uf.csv")

