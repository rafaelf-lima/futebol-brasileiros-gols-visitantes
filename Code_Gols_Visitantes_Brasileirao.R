library(tidyverse)
library(data.table)
library(ddplot)

mb <- read.csv("C:\\Users\\ritad\\brasileirao_serie_a.csv")
view(mb)

mb <- mb %>% 
  select(ano_campeonato, time_vis, gols_vis) %>% 
  #replace(is.na(.), 0) %>% 
  group_by(time_vis, ano_campeonato) %>% 
  summarise(gols_epoca = sum(gols_vis))

mb[24,3] = 22




mb <- mb %>% 
  complete(ano_campeonato = 2003:2020, fill = list(gols_epoca = 0)) %>% 
  mutate(gols_acumulados = cumsum(gols_epoca)) %>% 
  filter(time_vis %in% c("Atlético-MG", "Santos FC", "São Paulo", "Botafogo", "Cruzeiro", "Internacional", "Grêmio", "Palmeiras",
                         "Corinthians", "Flamengo", "Fluminense", "Vasco da Gama"))


 

mb %>% barChartRace(
  x = "gols_acumulados",
  y = "time_vis",
  time = "ano_campeonato",
  title = "Os clubes que mais marcaram gols atuando como visitantes entre 2003 e 2020 no Brasileirão Série A",
  frameDur = 750,
  colorCategory = "Paired",
  bgcol = "#F2DFCE",
  xgridlinecol = "#D0B9BD",
  panelcol = "#F2DFCE",
  titleFontSize = 18,
  xFontSize = 10.5,
  yFontSize = 10,
  opacity = 0.8
)
