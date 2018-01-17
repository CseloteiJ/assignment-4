stemp$dt <- as.Date(stemp$dt, "%Y-%m-%d")
#changes date from factor to numerical, temperature's format is already correct

tempiwant <- stemp %>%
  filter(dt >= '2000-01-01' & dt < '2001-01-01' & pop_2017 > 1000000)
#filters for dates since 2000 and population measures greater than 1 million

tempiwant <- tempiwant %>%
  mutate(citycountry = format(paste(city, country)))
#makes new column containing city and country together

tempiwant.city <- tempiwant %>%
  group_by(citycountry) %>%
  summarize(mean(AverageTemperature))
tempiwant.city <- rename(tempiwant.city, 't2000' = 'mean(AverageTemperature)')
#made new column with average temperature in 2000

temp.less <- unique(tempiwant[,c(1, 6:9)])
#now no figures exist as doubles for latitude and longitude

temp.plot <- merge(tempiwant.city, temp.less, by='citycountry')

ggplot(data = temp.plot) +
  geom_polygon(data = map_data('world'), mapping = aes(x = long, y = lat, group=group), fill = NA, color='black') +
  geom_point(mapping = aes(x=lng, y=lat, color=t2000, size=pop_2017)) +
  labs(x = "Longitude", y = "Latitude", color = "Temperature", size = "Population")
#plots worlds map with temperature data from 2000