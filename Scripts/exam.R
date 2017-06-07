#EXAM

#selected african countries, over 2mill baby deaths in 2007 (given in nr babies/1000, pop * nr babier/1000, mutate)
#gdp in us million dollars
#fertility, gdp_billion, gdpPercap, infanMort, lifeExt, pop_min
#kongo, egypt, nigeria



#inner_join(x, y), kun overlappende data
#full_join(x, y), alle verdiene fra begge datasettene (vil ha NA i seg)
#left_join(x, y), alt man har på venstre side, ofrer noe på høyre side. landene blir x - det man sender fra. 
#right_join(x, y)
#semi_join(x, y)



gapminder_plus <- read_csv(file = "Data/gapminder_plus.csv")


gapminder_plus %>% 
#filtrere for å finne ønskede land
    filter(continent == "Africa", year == 2007) %>% 
    mutate(babydeaths = infantMort*pop/10^3) %>% 
#>2e6 eller <2000000
    filter(babydeaths > 2000000) %>% 
#velger kun disse landene  
    select(country) %>% 
#joiner tilbake disse landene til som vi valgte, få alle abservasjonene fra disse landene        
    left_join(gapminder_plus) %>% 
    mutate(babydeaths = infantMort*pop/10^3, 
        gdp_bln = gdpPercap*pop/1e9,
        pop_mln = pop/1e6) %>% 
    select(-c(continent, pop, babydeaths)) %>% 
#kolonnenavn som variabel, key=nytt variabelnavn, value
    gather(key = variable, value = values, -country, -year) %>% 
#Eller: gather(key = variable, value = values, c(fert, infantMort, babydeaths, gdpPercap, pop, lifeExp) %>% select(-continent)
        ggplot() +
        geom_text(data=. %>%  filter(year == 2007) %>% 
                    group_by(variable) %>% 
                   mutate(max_value = max(values)) %>% 
                  filter(values == max_value), 
                  aes(x = year, y = values, label = country, color = country)) +
          geom_line(mapping =aes(x= year, y = values, color = country)) +
          facet_wrap(~ variable, scales = "free_y") +
          labs(title = "Final Project", subtitle = "07.06.2017", caption = "R carpentry", x = "Year", y = NULL) +
          theme_bw()+ theme(legend.position = "none")

gapminder_plus

gapminder_plus %>% 
  ggplot() +
  geom_line(mapping = aes(x = year, y = lifeExp, color = continent, group = country)) +
  geom_smooth(mapping = aes(x = year, y = lifeExp), method = "lm", color = "black") +
  facet_wrap(~ continent)

by_country <- gapminder_plus %>% group_by(continent, country) %>% 
  nest()

by_country$data[[1]]
library(purrr)
#map(list, function). lage lister inne i liste, regne ut stk, flytte ut igjen til hover dataframe
#model_by_country <- 
 #filtrere ut land som har dårlig rsquared ved lineær modell, så plotte kun disse
 
  by_country %>% 
  mutate(model = purrr::map(data, ~lm(lifeExp~year, data =.x))) %>% 
  mutate(summr = map(model, broom::glance)) %>% 
                  unnest(summr) %>% 
                  arrange(r.squared) %>% 
                  filter(r.squared < 0.5) %>% 
                  select(country) %>% 
                  left_join(gapminder_plus) %>% 
  ggplot() +
    geom_line(mapping = aes(x = year, y = lifeExp, color = country, group = country)) 
    

model_by_country$summr[[1]]

#lifeExp dependent on gdpPercap, does money make you live loner? which countried cannot buy their life
gapminder_plus %>% 
  ggplot() +
  geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, group = country)) +
  geom_smooth(mapping = aes(x = log(gdpPercap), y = lifeExp), method = "lm", color = "black") +
  facet_wrap(~ continent)


by_country %>% 
  mutate(model = purrr::map(data, ~lm(lifeExp~log(gdpPercap), data =.x))) %>% 
  mutate(summr = map(model, broom::glance)) %>% 
  unnest(summr) %>% 
  arrange(r.squared) %>% 
  filter(r.squared < 0.1) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  ggplot() +
  geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp, color = country, group = country)) +
  facet_wrap(~ continent)
  

saveRDS(by_country, "by_country_tibble.rds")

my_fresh_by_country <- readRDS("by_country_tibble.rds")

write_csv(gapminder_plus, "gapminder_plus_save.csv")







