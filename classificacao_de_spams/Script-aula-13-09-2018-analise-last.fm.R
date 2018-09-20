# Configurando o diretorio de trabalho
setwd("/Users/lucas/Documents/P??s-POLI/analise preditivas/Rosangela/")

# Verificar o diret??rio de trabalho atual
getwd()


install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("e1071")
install.packages("gmodels")

library("tm")
library("SnowballC")
library("wordcloud")
library("e1071")
library("gmodels")


# Carregando o arquivo do tipo CSV no R
base <- read.csv(file='.csv')
