download.file(url = c("http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
                      "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx"), 
              destfile = c("Data/indicator undata total_fertility.xlsx", 
                           "Data/indicator gapminder infant_mortality.xlsx"))

gapminder <- read_csv("Data/gapminder-FiveYearData.csv")
gapminder


library("readxl")
raw_fert <- read_excel(path = "Data/indicator undata total_fertility.xlsx", sheet = "Data")
raw_infantMort <- read_excel(path = "Data/indicator gapminder infant_mortality.xlsx")

head(raw_fert)
#Fra vidt til langt format
#Tre variabler, id-variabel, name for observation variable, which columns to collect, 
fert <- raw_fert %>% 
        rename(country = `Total fertility rate`) %>% 
        gather(key = year, value = fertility, -country) %>% 
        mutate(year = as.integer(year))
fert