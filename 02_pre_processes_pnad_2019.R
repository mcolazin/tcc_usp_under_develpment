library(PNADcIBGE)
library(tidyverse)

# Carregamento dos dados do Pnad 2019
pnad_2019 = get_pnadc(year = 2019, design = FALSE, interview = 1)

#