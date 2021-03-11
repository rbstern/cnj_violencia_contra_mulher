library(readxl)
library(tidyverse)

indicadores = c("cncf", "cpcf", 
                "epif", "epp", 
                "equipe", "gp", "mp", "ve",
                "pbcf", "pbef", 
                "scf", "sepf")
anos = c("19", "20")

raw_data_path = "./data_raw/"

data_f = NULL
for(id in indicadores)
{
  for(ano in anos)
  {
    data_f = paste(raw_data_path, id, "_", ano, ".xlsx", sep = "") %>% 
      read_xlsx() %>% 
      mutate(ano = ano,
             key = id) %>% 
      select(tribunal = Tribunal,
             value := Indicador,
             key, ano) %>% 
      rbind(data_f)
  }
}

data_f %>% 
  spread("key", "value") %>% 
  write_csv("./data/indicadores_tj.csv")
