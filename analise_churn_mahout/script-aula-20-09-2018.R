# Configurando o diretorio de trabalho
setwd("/Users/lucas/Documents/P??s-POLI/analise preditivas/Rosangela/analise_churn_mahout/")

getwd()

#carregando arquivo csv no R; T indica que o arquivo tem um cabe??alho
churn_data<-read.csv("churn.all",header=T)

#visualizando dados
View(churn_data)

#estatisticas dos dados
summary_all<-summary(churn_data)
summary_all

#resumo de todos os clientes desistentes, ser?? chamada a fun????o summary.
#Os subconjuntos de dados s??o obtidos com a condi????o Status==True.
summary_churn <-summary(subset(churn_data, Status=='True'))

#Para obter um resumo de todos os clientes ativos, a fun????o summary receber?? o par??metro Status==False
summary_active<-summary(subset(churn_data, Status=='False'))

#Para combinar todos os data frames em um ??nico arquivo, ser?? chamada a 
#fun????o rbind() com os 3 data frames criados, gerando um arquivo csv.
write.csv(rbind(summary_all, summary_churn, summary_active), file="summary_file.csv")

#Como tratamento dos dados, iremos remover as vari??veis n??o num??ricas:
cor_data<-churn_data
cor_data$Status<-NULL
cor_data$voice.mail.plan<-NULL
cor_data$international.plan <-NULL
cor_data$phone.number<-NULL
cor_data$state<-NULL



