

library(dplyr)
# 'Ano'	'UF'	'Código do Órgão'	'Órgão'	'Código UO'	'Unidade Orçamentária'	
# 'Função'	'Subfunção'	'Programa'	'Ação'	'Descrição da Ação'
# 'ValorP&D'	'ValorACTC'	'Total'	'Validação'

despr19<-TB_DESPESA_2019 %>% 
  select(valor_liquidado,
         funcao_cod,
         orgao_cod,
         orgao_nome,
         programa_cod,
         projeto_atividade_cod,
         projeto_atividade_nome,
         sub_funcao_cod,
         unidade_cod,
         unidade_nome)%>%
  filter(sub_funcao_cod==541|
         sub_funcao_cod==542|
         sub_funcao_cod==544|
         sub_funcao_cod==545|
         sub_funcao_cod==571|
         sub_funcao_cod==572|
         sub_funcao_cod==573|
         sub_funcao_cod==606|
         sub_funcao_cod==661|
         sub_funcao_cod==663|
         sub_funcao_cod==664|
         sub_funcao_cod==665)
         

palavrasPR19<-as.data.frame(despr19$projeto_atividade_nome) 

parana19.resumo<-aggregate(x = list(valor.liquidado=despr19$valor_liquidado), 
                  by = list(nome.acao=despr19$projeto_atividade_nome,
                            sub.func=despr19$sub_funcao_cod,
                            nome.orgao=despr19$orgao_nome,
                            nome.unidade=despr19$unidade_nome),
                  FUN = sum)


############################################################################
# Examinando a estrutura dos dados

palavras_chave<-as.data.frame(palavras_chave)
str(palavras_chave)


# Convertendo para fator
palavras_chave$palavras_chave <- factor(palavras_chave$palavras_chave)

# Examinando a estrutura dos dados
str(palavras_chave$palavras_chave)
table(palavras_chave$palavras_chave)

# Construindo um Corpus
dados_corpus <- VCorpus(VectorSource(palavras_chave$palavras_chave))

# Examinando a estrutura dos dados
print(dados_corpus)
inspect(dados_corpus[1:2])

# Ajustando a estrutura
as.character(dados_corpus[[1]])
lapply(dados_corpus[1:2], as.character)

# Limpeza do Corpus com tm_map()
?tm_map
dados_corpus_clean <- tm_map(dados_corpus, content_transformer(tolower))

# Diferen?as entre o Corpus inicial e o Corpus ap?s a limpeza
as.character(dados_corpus[[1]])
as.character(dados_corpus_clean[[1]])

# Outras etapas de limpeza
dados_corpus_clean <- tm_map(dados_corpus_clean, removeNumbers) # remove n?meros
dados_corpus_clean <- tm_map(dados_corpus_clean, removeWords, stopwords("por")) # remove stop words
dados_corpus_clean <- tm_map(dados_corpus_clean, removePunctuation) # remove pontua??o

# Eliminando espa?o em branco
dados_corpus_clean <- tm_map(dados_corpus_clean, stripWhitespace) 

# Examinando a vers?o final do Corpus
lapply(dados_corpus[1:3], as.character)
lapply(dados_corpus_clean[1:3], as.character)

# Criando uma matriz esparsa document-term
?DocumentTermMatrix
dados_dtm <- DocumentTermMatrix(dados_corpus_clean)

# Word Cloud
wordcloud(dados_corpus_clean, min.freq = 50, random.order = FALSE)

wordcloud(dados_corpus_clean,min.freq=50,random.order=FALSE,
          scale=c(1,0.5),color=rainbow(4))

           


         
                  
