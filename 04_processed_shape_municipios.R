pacotes <- c("rgdal","raster","tmap","maptools","sf","rgeos","sp","adehabitatHR",
             "tidyverse","broom","rayshader","knitr","kableExtra","RColorBrewer",
             "profvis")
sapply(pacotes, require, character=TRUE)
setwd("d:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/processed_files/3 ibge_pib_idh_gini/")
getwd()

# Load Data Shape
shape_munic = readOGR(dsn = "shape_file_municipios", layer = "BR_Municipios_2019")
class(shape_munic)
typeof(shape_munic)

# Load Data Enade
enade_2019 = read.csv("01a_enade_2019_summary_mean_grade_by_citie.csv", encoding = "UTF-8")
enade_2019 = enade_2019 %>%
  rename("cod_mun_ibge" = 1) %>%
  select(cod_mun_ibge, mean_grades_group_cities)

# Load Pib Data
pib_mun_2019 = read.csv("02_pib_processed.csv", encoding = "UTF-8")
pib_mun_2019 = pib_mun_2019 %>%
  select(cod_mun, pib_p_capta)

# Load GINI Data
gini_data = read.csv("01_gini_processed.csv", encoding = "UTF-8", sep = ";")

# Load ANATEL DATA By Total Density
anatel_data = read.csv("01c_anatel_internet_access_processed.csv", encoding = "UTF-8")
anatel_data = anatel_data %>%
  select(cod_municipio_ibge, fibra_optica, wifi, ethernet, lte, vsatelite, wimax, plc_eletrico, xdsl, cable_modem, fwa_5g_fixed,
         atm_backbone, dth_satelite, hfc_tv_cabo, fr_frame_relay, mmds) %>%
  group_by(cod_municipio_ibge) %>%
  summarise(densidade_total_internet_fixa = fibra_optica + wifi + ethernet + lte + vsatelite + wimax + plc_eletrico + xdsl + cable_modem 
            + fwa_5g_fixed + atm_backbone + dth_satelite + hfc_tv_cabo + fr_frame_relay + mmds)

# Load Anatel Data By Each Internet Category
anatel_data_each_technology = read.csv("01c_anatel_internet_access_processed.csv", encoding = "UTF-8")
anatel_data_each_technology = anatel_data_each_technology %>%
  select(cod_municipio_ibge, fibra_optica, wifi, ethernet, lte, vsatelite, wimax, plc_eletrico, xdsl, cable_modem, fwa_5g_fixed,
         atm_backbone, dth_satelite, hfc_tv_cabo, fr_frame_relay, mmds)

# Load ANATEL DATA By Total Density BY UF
anatel_data_uf = read.csv("01d_anatel_internet_access_processed_by_uf.csv", encoding = "UTF-8")
anatel_data_uf = anatel_data %>%
  select(UF, fibra_optica, wifi, ethernet, lte, vsatelite, wimax, plc_eletrico, xdsl, cable_modem, fwa_5g_fixed,
         atm_backbone, dth_satelite, hfc_tv_cabo, fr_frame_relay, mmds) %>%
  group_by(UF) %>%
  summarise(densidade_total_internet_fixa = fibra_optica + wifi + ethernet + lte + vsatelite + wimax + plc_eletrico + xdsl + cable_modem 
            + fwa_5g_fixed + atm_backbone + dth_satelite + hfc_tv_cabo + fr_frame_relay + mmds)

# merge new Shape Data Enem
shape_munic_enem = merge(x = shape_munic, y = enade_2019, 
                         by.x = "CD_MUN", by.y = "cod_mun_ibge")
# merge new shape data pib
shape_munic_enem_pib = merge(x = shape_munic_enem, y = pib_mun_2019,
                             by.x = "CD_MUN", by.y = "cod_mun")
# merge new shape data with GINI
shape_munic_enem_pib_gini = merge(x = shape_munic_enem_pib, y=gini_data,
                                  by.x = "SIGLA_UF", by.y = "uf")
# merge new shape data with Anatel Data
shape_munic_enem_pib_gini_anatel = merge(x = shape_munic_enem_pib_gini, y=anatel_data,
                                  by.x = "CD_MUN", by.y = "cod_municipio_ibge")
# merge new shape data with the entire anatel Internet Data Access
shape_munic_enem_pib_gini_anatel_by_techs = merge(x = shape_munic_enem_pib, y= anatel_data_each_technology,
                                         by.x = "CD_MUN", by.y = "cod_municipio_ibge")
# merge new shape data with Anatel Data BY UF
shape_munic_enem_pib_gini_anatel_uf = merge(x = shape_munic_enem, y=anatel_data_uf,
                                         by.x = "SIGLA_UF", by.y = "UF")

# view Enem MAP
tm_shape(shape_munic_enem) + tm_fill(col = "mean_grades_group_cities",
                                     legend.show = TRUE,
                                     legend.hist = TRUE)
# view PIB Map
tm_shape(shape_munic_enem_pib) + tm_fill(col = "pib_p_capta",
                                         legend.show = TRUE,
                                         legend.hist = TRUE, n = 20)

# view GINI Map
tm_shape(shape_munic_enem_pib_gini) + tm_fill(col = "gini",
                                         legend.show = TRUE,
                                         legend.hist = TRUE)

# view ANATEL Map by total density
tm_shape(shape_munic_enem_pib_gini) + tm_fill(col = "densidade_total",
                                              legend.show = TRUE,
                                              legend.hist = TRUE, n = 30)

# view ANATEL Map by technology accesss - fibra optica
tm_shape(shape_munic_enem_pib_gini_anatel_by_techs) + tm_fill(col = "fibra_optica",
                                              legend.show = TRUE,
                                              legend.hist = TRUE, n=30)

# view ANATEL Map by technology accesss - XDSL
tm_shape(shape_munic_enem_pib_gini_anatel_by_techs) + tm_fill(col = "xdsl",
                                                              legend.show = TRUE,
                                                              legend.hist = TRUE, n = 30)

# view ANATEL Map by TOTAL accesss - UF
tm_shape(shape_munic_enem_pib_gini_anatel_uf) + tm_fill(col = "densidade_total_internet_fixa",
                                                              legend.show = TRUE,
                                                              legend.hist = TRUE)



































