library(BSDA)
library(tidyverse)

# A basketball player will take shots until she misses two (the misses don’t have to be
# consecutive). Given that each shot has a probability p of success, write an R function to
# estimate the mean number of shots that she will take before stopping. (The chance of success
# of any shot is independent from that of any other shot).

simulate_100_games <- function(p_success) {
  num_shots <- numeric(100)
  # do 100 games
  for (i in 1:100) {
    # for each game, build list of shots until 2 misses 
    curr_shots <- character()
    while (sum(curr_shots == "MISS") < 2) {
      curr_shots <- append(curr_shots, ifelse(runif(1, 0, 1) < p_success, "SUCCESS", "MISS"))
    }
    # count shots and add to results list
    num_shots[i] <- length(curr_shots)
  }
  return(num_shots)
}

mean(simulate_100_games(.8))

# What is the distribution of the number of shots the player takes if p=0.80?
# should be a negative binomial distribution, E(X) = r/p = 2/.2 = 10, Var(X) = r*(1-p) / p^2 = 2(.8)/.04 = 40
hist(simulate_100_games(.8))

# Provide suitable test(s) to show that your function is correct.
print(z.test(x = simulate_100_games(.8), mu = 10, sigma.x = sqrt(40)))

# How could we use your function to study the association between the probability of making a
# shot with the mean number of shots that the player takes before missing 2?
# - put in a range of p_success and graph
probs <- seq(0.1, 0.9, by = 0.1)
results <- data.frame(
  p = probs,
  mean_shots = sapply(probs, function(prob) {mean(simulate_100_games(prob))})
)
ggplot(data=results, aes(x=p, y=mean_shots)) +
  geom_point() +
  geom_line() +
  labs(title="Probability of making a shot vs mean number of shots before missing 2", 
       x="P(making a shot)", y="Mean trials before missing 2") +
  theme_minimal()
