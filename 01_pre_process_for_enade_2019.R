# ETL Enade 2019 Data

setwd("D:/atividades/atividades/pos_usp_data_science_analitycs/tcc/data/data/2/")
getwd()

# libraries
library(tidyverse)
library(reshape2)

# read csv and select some colums # Remove observations without grades
enade_2019 = read.csv(file = "MICRODADOS_ENEM_2019.csv", sep = ";")
enade_2019 = enade_2019 %>%
  select(CO_MUNICIPIO_RESIDENCIA, NO_MUNICIPIO_RESIDENCIA, SG_UF_RESIDENCIA, NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, NU_NOTA_REDACAO) %>%
  filter( (NU_NOTA_CN != "NA") & (NU_NOTA_CH != "NA") & (NU_NOTA_LC != "NA") & (NU_NOTA_MT != "NA") ) 

# structure of data:
str(enade_2019)
# summary of data
summary(enade_2019)

# prepare data to melt in a unique boxplot - to verify grade distributions 
data_for_box = melt(enade_2019[c("NU_NOTA_CN", "NU_NOTA_CH", "NU_NOTA_LC", "NU_NOTA_MT")])
ggplot(data_for_box) + aes(x = variable, y = value) + geom_boxplot()
rm(data_for_box) # clean data memory 

# the grades are nearly distributed in a aproximate range
# lets try to work with a unified grade
# unified grade = mean from c("NU_NOTA_CN", "NU_NOTA_CH", "NU_NOTA_LC", "NU_NOTA_MT")


# mutate dataFrame to calculate the means of all grades:
enade_2019_with_mean = enade_2019 %>%
  mutate(media_CN_CH_LC_MT = (NU_NOTA_CN + NU_NOTA_CH + NU_NOTA_LC + NU_NOTA_MT) / 4 ) %>%
  select(CO_MUNICIPIO_RESIDENCIA, NO_MUNICIPIO_RESIDENCIA, SG_UF_RESIDENCIA,media_CN_CH_LC_MT) %>%
  data.frame()

# Summarize DF with means of Grade By city:
enade_2019_summarize = enade_2019_with_mean %>%
  group_by(CO_MUNICIPIO_RESIDENCIA, NO_MUNICIPIO_RESIDENCIA, SG_UF_RESIDENCIA) %>%
  summarize(mean_grades_group_cities = mean(media_CN_CH_LC_MT, na.rm = TRUE)) %>%
  data.frame()

# Write file to a new Processed Enade CSV
write_csv(x = enade_2019_summarize, file = "enade_2019_summary_mean_grade_by_citie.csv")

  
  
  
  
  
  
  
  
  


























  