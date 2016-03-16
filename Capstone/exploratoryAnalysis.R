library(wordcloud)
library(ggplot2)
library(dplyr)

#Word cloud representation
cloud <- wordcloud(names(token_table[1:100]),token_table[1:100])

#Create list of bigrams and trigrams
bigrams <- ngrams(tokens,2)
trigrams <- ngrams(tokens,3)

#Create data frame with tokens frequencies and word length
tokenDF <- data.frame(token = names(token_table), freq = as.vector(token_table))
tokenDF$token <- as.vector(tokenDF$token)
tokenDF <- mutate(tokenDF, length = nchar(token))

bigramDF <- data.frame(gram = names(bigram_table), freq = as.vector(bigram_table))
bigramDF$gram <- as.vector(bigramDF$gram)

trigramDF <- data.frame(gram = names(trigram_table), freq = as.vector(trigram_table))
trigramDF$gram <- as.vector(trigramDF$gram)


#Plot word frequencies
ggplot(tokenDF[1:50,], aes(token,freq)) + geom_label( aes(label = token)) + scale_x_discrete(limits=tokenDF$token[1:50]) + theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(bigramDF[1:50,], aes(gram,freq)) + geom_label( aes(label = gram)) + scale_x_discrete(limits=bigramDF$gram[1:50]) + theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(trigramDF[1:50,], aes(gram,freq)) + geom_label( aes(label = gram)) + scale_x_discrete(limits=trigramDF$gram[1:50]) + theme(axis.text.x = element_text(angle = 90, hjust = 1))

quantile(tokenDF$freq)
