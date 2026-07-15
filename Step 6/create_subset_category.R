library(readxl)
library(readr)
library(stringi)

################################################################################

### Step a: from the ~200 validated sentences keep only those for which the human evaluators and OpenAI agree

#Import the dataset
validated_sentences <- read_excel("validated_sentences.xlsx")

#Count the occurrences of each category
table(validated_sentences$Category)

#Create a subset of sentences for each category
subset_methods <- validated_sentences[validated_sentences$Category=="Ancestry-Inference Tools, Markers, and Analytic Approaches",]  
subset_evolution <- validated_sentences[validated_sentences$Category=="Ancestry in Evolution and Lineage Relationships",]
subset_popstruct <- validated_sentences[validated_sentences$Category=="Ancestry in Population Structure and Genetic Variation",]
subset_health <- validated_sentences[validated_sentences$Category=="Genetic Ancestry and Health",]
subset_identity <- validated_sentences[validated_sentences$Category=="Human Ancestry, Identity, Geography, and Demography",] 
subset_unclear <- validated_sentences[validated_sentences$Category=="Unclear",] 

#Save the validated sentences in CSV files with sentences only (one file per category)
write.csv(subset_methods[1],"validated_methods.csv",row.names=F)
write.csv(subset_evolution[1],"validated_evolution.csv",row.names=F)
write.csv(subset_popstruct[1],"validated_popstruct.csv",row.names=F)
write.csv(subset_health[1],"validated_health.csv",row.names=F)
write.csv(subset_identity[1],"validated_identity.csv",row.names=F)
write.csv(subset_unclear[1],"validated_unclear.csv",row.names=F)