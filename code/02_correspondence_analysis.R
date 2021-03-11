library(FactoMineR)
library(factoextra)
library(tidyverse)

data = read_csv("./data/indicadores_tj.csv")

print_ca = function(anos_selecionados)
{
  paste(c("./figures/ca", anos_selecionados), collapse = "_") %>% 
    paste(".pdf", sep = "") %>% 
    pdf()
  data_m = data %>%
    filter(ano %in% anos_selecionados,
           tribunal != "TJ") %>% 
    mutate(tribunal = paste0(tribunal, ano, sep = "")) %>% 
    column_to_rownames(var = "tribunal") %>% 
    select(-ano, -equipe, -mp) %>% 
    na.omit %>% 
    CA(ncp = 5, graph = TRUE)
  dev.off()
}

print_ca(c(19))
print_ca(c(20))
print_ca(c(19, 20))
