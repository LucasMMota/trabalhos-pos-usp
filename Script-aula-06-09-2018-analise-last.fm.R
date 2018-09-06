# Configurando o diret??rio de trabalho
setwd("/Users/lucas/Documents/P??s-POLI/analise preditivas/rosangela/")

# Verificar o diret??rio de trabalho atual
getwd()

# Carregando o arquivo do tipo CSV no R
base <- read.csv(file='lastfm.csv')

# Obtendo os resultados das primeiras 7 linhas e das colunas 1, 3, 4, 5, 6, 7 e 8
head(base[,c(1,3:8)])

# Retirando a coluna de usu??rios
#c(linha,coluna)
base.msc <- (base[,!(names(base) %in% c("user"))])

# Fun????o para c??lculo do cosseno entre dois vetores
getCosseno<- function(x,y)
{;
  cosseno <- sum(x*y) / (sqrt(sum(x*x)) * sqrt(sum(y*y)));
  return(cosseno);
};

# Criar uma matriz para armazenar as medidas de similaridade entre os itens
base.msc.cosseno <- matrix(NA, nrow=ncol(base.msc), ncol=ncol(base.msc), dimnames=list(colnames(base.msc), colnames(base.msc)))

for(i in 1:ncol(base.msc)) {;
  for(j in 1:ncol(base.msc)) {;
    base.msc.cosseno[i,j] <-
      
      getCosseno(as.matrix(base.msc[i]),as.matrix(base.msc[j]))
  };
};

# Converter a matriz de similaridade em um data frame
base.msc.cosseno <- as.data.frame(base.msc.cosseno)

head(base.msc.cosseno[,c(1,3:5)])

# Criar uma nova matriz para armazenar os top-10 vizinhos mais pr??ximos de cada item
base.vizinhos <- matrix(NA, nrow=ncol(base.msc.cosseno), ncol=11, dimnames=list(colnames(base.msc.cosseno)))

#Ordenar a matriz em ordem decrescente de similaridade
for(i in 1:ncol(base.msc))
{;
  base.vizinhos[i,] <-(t(head(n=11,rownames(base.msc.cosseno[order(base.msc.cosseno[,i],decreasing=TRUE),][i]))));
};

View(base.vizinhos)

#gravar o resultado
write.csv(file="lastfm-top10.csv",x=base.vizinhos[,-1])
