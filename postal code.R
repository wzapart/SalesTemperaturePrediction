install.packages("readxl")
install.packages("stringr")
library(stringr)
library(readxl)

data_shumee<-read_xlsx(file.choose())

data_shumee_PL<-data_shumee[data_shumme$Kraj=="PL",]

str(data_shumee_PL)
class(data_shumee_PL$`Kod Pocztowy`)

postal_code_rx<-str_extract(data_shumee_PL$`Kod Pocztowy`,"\\d\\d\\-\\d\\d\\d")
data_shumee_PL$`Kod Pocztowy`<-postal_code_rx
data_shumee_PL_clean<-na.omit(data_shumee_PL)
code1<-substr(data_shumee_PL_clean$`Kod Pocztowy`,start=1,stop=1)
code1

data_shumee_PL_clean$code1<-code1

data_shumee_merged<-merge(data_shumee_PL_clean,postalcode_df,by.x="code1",by.y="first_character")

head(data_shumee_merged)

