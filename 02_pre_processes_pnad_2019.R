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
list_municipio = remuneracao_uf_mean_sd$UF 
remuneracao_uf_mean_sd_renamed = remuneracao_uf_mean_sd %>%
  mutate(UF = recode(UF,
                     "Rondônia" = "RO",
                     "Acre" = "AC",
                     "Amazonas" = "AM",
                     "Roraima" = "RR",
                     "Pará" = "PA",
                     "Amapá" = "AP",
                     "Tocantins" = "TO",
                     "Maranhão" = "MA"))
