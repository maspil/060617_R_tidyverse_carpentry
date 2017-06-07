library(dplyr)

#select()
#filter()
#group_by()
#summarise()
#mutate() - create new variables

gapminder <- read_csv("Data/gapminder-FiveYearData.csv")

#Base R, repeat
rep("This is an example", times = 5)

#shift + cmd + m = %>%
#dplyr repeat
"This is an example" %>% 
  rep(times =3)

#Select columns from dataframe
year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

#Same result, different method
year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)
year_country_gdp

#Filtrerer ut dataene vi vil se på, pg piper videre til ggplot
gapminder %>% 
  filter(year ==2002) %>% 
  ggplot(mapping = aes(x = continent, y = pop)) +
  geom_boxplot()

year_country_gdp_euro <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)


year_lifeexp_gdp_nor <- gapminder %>% 
  filter(country == "Norway") %>% 
  select(year, lifeExp, gdpPercap)

#Gruppere data i henhold til en variabel
gapminder %>% 
  group_by(continent)

#Regne ut gjennomsnittet av en variabel innenfor hver gruppe
#dplyr
gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_gdpPercap = mean(gdpPercap))

gapminder %>% 
  summarise(mean_gdpPercap = mean(gdpPercap))

#plot mean per gruppe
gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_gdpPercap = mean(gdpPercap)) %>% 
  ggplot(mapping = aes(x = continent, y = mean_gdpPercap)) +
           geom_point()

#Filtrere på kontinent, gruppere på land, regne gjennomsnitt per land, plotte, sortere på alfabet
gapminder %>% 
  filter(continent == "Asia") %>% 
  group_by(country) %>% 
  summarise(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(mapping = aes(x = country, y = mean_lifeExp)) +
  geom_point() +
  order() +
  coord_flip()
  
#alt + 7 = | (or)

#Filtrere på kontinent, gruppere på land, summary av min og max gjennomsnitt
gapminder %>% 
  filter(continent == "Asia") %>% 
  group_by(country) %>% 
  summarise(mean_lifeExp = mean(lifeExp)) %>% 
  filter(mean_lifeExp == min(mean_lifeExp)|mean_lifeExp == max(mean_lifeExp))


#mutate - new variable
#Summary statistics for every continent and year
gapminder %>% 
  mutate(gdp_billion = gdpPercap*pop/10^9) %>% 
  group_by(continent, year) %>% 
  summarise(mean_gdp_billion = mean(gdp_billion))
 
#maps
gapminder_country_summary <- gapminder %>% 
                                group_by(country) %>% 
                                summarise(mean_lifeExp = mean(lifeExp))

library(tidyverse)
library(maps)
map_data("world") %>% 
  rename(country = region) %>% 
  left_join(gapminder_country_summary, by= "country") %>% 
  ggplot() + 
      geom_polygon(aes(x = long, y = lat, group = group, fill = mean_lifeExp)) +
      scale_fill_gradient(low = "blue", high = "red") +
      coord_equal()






