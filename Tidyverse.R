#Directory
~/Documents/R-carpentry/060617_tidyverse
library("tidyverse")

gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")
gapminder

#1_Simple point-plot
ggplot(data= gapminder) + 
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))

#2_Jitter, color
ggplot(data= gapminder) + 
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color = continent))

#3_Scale log_x, size
ggplot(data= gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop))

#4_Utenfor aes() gjelder er funksjonene konstante for alle datapunkter, color, size, alpha
ggplot(data= gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), 
             color = "blue", size = 2, alpha = 0.1)

#5_Line, group= grupper alle observasjonene fra hvert land
ggplot(data= gapminder) + 
  geom_line(mapping = aes(x = year, y = lifeExp, 
             color = continent, group = country))

#6_Boxplot, each continent
ggplot(data= gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

#7_jitter + box, color, nedarving
ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, color = continent)) + 
  geom_jitter() +
  geom_boxplot()

#8_smooth
ggplot(data = gapminder, mapping = aes(x = log (gdpPercap), y = lifeExp, color = continent)) + 
  geom_jitter(alpha =0.1) +
  geom_smooth(method = "lm")

#9_Fjernet farge fra hovedfunksjonen, til spesifikk linje
ggplot(data = gapminder, mapping = aes(x = log (gdpPercap), y = lifeExp)) + 
  geom_jitter(aes(color = continent), alpha =0.5) +
  geom_smooth(method = "lm")

#10_Boxplot, lifeexp per year, kontinuelig variabel year som faktor, kategorisk variabel 
#(factor, as.factor, as.charachter)
ggplot(data = gapminder, mapping = aes(x = factor(year), y = lifeExp)) + 
  geom_boxplot()

#Densisitetsplot
ggplot(data = gapminder) +
  geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap)))

#facet continent, fitted line
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() + 
  geom_smooth() +
  scale_x_log10() + 
  facet_wrap(~ continent)

#Facet year, straight line
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() + 
  geom_smooth(method ="lm") +
  scale_x_log10() + 
  facet_wrap(~ year)

#Filter
filter(gapminder, year == 2007)

#Bar-greaf, filtrert for år, uspesifisert y (count, teller antall hendelser i kategorien)
ggplot(data = filter(gapminder, year == 2007)) + 
  geom_bar(mapping = aes(x = continent))

#spesifisert y
ggplot(data = filter(gapminder, year == 2007)) + 
  geom_bar(mapping = aes(x = continent), stat = "count")

#filtrer på to variable, y identity, tallet fra pop. Ingen transformasjon, rådata
#filter(gapminder, year == 2007, continent == "Oceania")
ggplot(data = filter(gapminder, year == 2007, continent == "Oceania")) + 
  geom_bar(mapping = aes(x = country, y = pop), stat = "identity")

#Col= automatisk "identity" for y
ggplot(data = filter(gapminder, year == 2007, continent == "Oceania")) + 
  geom_col(mapping = aes(x = country, y = pop))

#Bytte vinkel på x, y          
ggplot(data = filter(gapminder, year == 2007, continent == "Asia")) + 
             geom_col(mapping = aes(x = country, y = pop)) +
              coord_flip()

#En graf per år, farge på kontinent, endrer populasjonen til pop i millioner
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/10^6)) + 
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ year) + 
  labs(title = "Life Expectancy vs GDP per capita over time", 
       subtitle = "In the last 50 years life expectancy has improved in most countries of the world", 
       caption = "Source: Gapminder foundation, gapminder.com",
       x = "GDP per capita, in ´000 USD",
       y = "Life Expectancy in years")

#LAgre siste plot i directory
ggsave("my_fancy_plot.png")

#help
?ggsave 

