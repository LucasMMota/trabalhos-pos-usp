# Configurando o diretorio de trabalho
setwd("/Users/lucas/Documents/Pós-POLI/analise preditivas/Rosangela/analise_churn_mahout/")

getwd()

#carregando arquivo csv no R; T indica que o arquivo tem um cabeçalho
churn_data<-read.csv("churn.all",header=T)

#visualizando dados
View(churn_data)

#estatisticas dos dados
summary_all<-summary(churn_data)
summary_all

#resumo de todos os clientes desistentes, será chamada a função summary.
#Os subconjuntos de dados são obtidos com a condição Status==True.
summary_churn <-summary(subset(churn_data, Status=='True'))

#Para obter um resumo de todos os clientes ativos, a função summary receberá o parâmetro Status==False
summary_active<-summary(subset(churn_data, Status=='False'))

#Para combinar todos os data frames em um único arquivo, será chamada a 
#função rbind() com os 3 data frames criados, gerando um arquivo csv.
write.csv(rbind(summary_all, summary_churn, summary_active), file="summary_file.csv")

#Como tratamento dos dados, iremos remover as variáveis não numéricas:
cor_data<-churn_data
cor_data$Status<-NULL
cor_data$voice.mail.plan<-NULL
cor_data$international.plan <-NULL
cor_data$phone.number<-NULL
cor_data$state<-NULL

#calc corr
correlation_all<-cor(cor_data)
write.csv(correlation_all,file="correlation_file.csv")

t<-read.csv("correlation_file.csv",header=T)
View(t)

#Olhando o arquivo correlation_file.csv, foram identificadas 4 colunas fortemente correlacionadas, que serão removidas.
churn_data$total.day.charge<-NULL
churn_data$total.eve.charge<-NULL
churn_data$total.night.charge<-NULL
churn_data$total.intl.charge<-NULL

# Também serão removidas as variáveis phone number e state.
churn_data$state<-NULL
churn_data$phone.number<-NULL
write.csv(churn_data, file="churn_data_clean.all.csv", row.names = F)

#Olhando para o conjunto de dados, há algumas possibilidades para construção manual de atributos. 
#Uma característica interessante seria calcular os minutos médios por chamada
churn_data$avg.minute.day<-churn_data$total.day.minutes / churn_data$total.day.calls
churn_data$avg.minute.eve<-churn_data$total.eve.minutes / churn_data$total.eve.calls
churn_data$avg.minute.night<-churn_data$total.night.minutes / churn_data$total.night.calls
churn_data$avg.minute.intl<-churn_data$total.intl.minutes / churn_data$total.intl.calls

# Agora iremos dividir o arquivo em conjunto de treinamento e conjunto de teste. 
# A divisão será de 75% de treinamento e 25% de teste. 
# Primeiro criamos a variável smp_size, que é de 75% do número de linhas do arquivo.
smp_size <- floor(0.75 * nrow(churn_data))

# Agora criamos uma amostra de 75% das linhas para treinamento 
set.seed(123) # inicia uma sequencia de numero aleatorios
train_ind <- sample(seq_len(nrow(churn_data)),size = smp_size)
train <- churn_data[train_ind, ]

#O conjunto de teste é criado pela não seleção das linhas previamente selecionadas: 
test <- churn_data[-train_ind, ]

#Para vermos a distribuição de clientes ativos e de churn no conjunto de treinamento:
table(train$Status)
#False True
#3219 531

table(test$Status)
#False True
#1074 176

