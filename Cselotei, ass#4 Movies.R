movies.mutated <- movies %>%
  mutate(
    comornot = ifelse(genres == "Comedy", "Comedy", "Not Comedy")
  )
#shows new category, whether it's comedy or not

movies$release_date <- as.Date(movies$release_date, '%Y-%m-%d')
#formats dates correctly to then be read properly for graph

movies$budget <- as.numeric(as.character(movies$budget))
#budget now made numerical instead of factor

movies.wbudget <- movies %>%
  filter(budget > 10000 & budget < 3e+08 & release_date > '1940-01-01' & vote_count > 20)
#only shows movies with certain budgets, as indicated above, and at least 20 votes

ggplot(data = movies.wbudget) +
  geom_point(mapping = aes(x=release_date, y=budget, color=vote_average)) +
  labs(x = "Release Date", y = "Budget [$]", color = "Average Vote\n")
#x shows release date, y shows budget
#we can see that overall budget of movies has been increasing through time