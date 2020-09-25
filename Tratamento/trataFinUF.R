
library(dplyr)
library(stringr)

exemploGO <- read_excel("D:/Joelmo/COIND/Dados Dispêndios Estados/Arquivos GO/100 - RelacaoAnexo11Resumo - 1a12_2019 editada.xlsx",
                         col_names = FALSE, skip = 10)

exemploGO.rec<-exemploGO %>% 
  select(...1,
         ...2,
         ...17)

names(exemploGO.rec)[1]<-"codigo"
names(exemploGO.rec)[2]<-"descricao.acao"
names(exemploGO.rec)[3]<-"valor.empenhado"

str(exemploGO.rec)

exemploGO.rec$funcao<-str_sub(exemploGO.rec$codigo, end = 2) # pegar apenas os dois primeiros caracteres
exemploGO.rec$subfuncao<-str_sub(exemploGO.rec$codigo, 3, 5)
exemploGO.rec$programa<-str_sub(exemploGO.rec$codigo, 6, 9)
exemploGO.rec$acao<-str_sub(exemploGO.rec$codigo, 10, 13)

exemploGO.rec<-exemploGO.rec %>% 
  select(funcao,
         subfuncao,
         programa,
         acao,
         descricao.acao,
         valor.empenhado)


write.csv(exemploGO.rec,"exemploGO.csv")
