#Course Project for Statistical Inference

#Part 1

set.seed(42)

nSim <- 10000
samples <- 40

lambda <- 0.2

theoretical.mean <- 1/lambda
theoretical.sd <- 1/lambda
theoretical.var <- theoretical.sd**2
theoretical.var.of.means <- theoretical.var/samples

sim <-matrix(rexp(nSim*samples, lambda), nSim, samples)

sim.means <- rowMeans(sim)
sim.sd <-apply(sim, 1, sd)
sim.se <- sim.sd/sqrt(samples)

sim.mean.of.means <- mean(sim.means)
sim.sd.of.means <- sd(sim.means)

hist(sim, breaks = 25)
abline(v = sim.mean)
abline(v = 1/0.2, col = "red")

hist(sim, breaks = 25, prob = T)
curve(dnorm(x, mean = mean(sim), sd = sd(sim)), add = T)




plot(sim.means[1:100], 
     ylim=range(c(sim.means[1:100]-1.96*(sim.se[1:100]), sim.means[1:100]+1.96*(sim.se[1:100])))
     )

arrows(1:100, sim.means[1:100]-1.96*(sim.se[1:100]), 1:100, sim.means[1:100]+1.96*(sim.se[1:100]), length=0.05, angle=90, code=3)
abline(h = 1/lambda, col = "red")
sum((sim.means-1.96*(sim.se) <= 5)&(sim.means+1.96*(sim.se) >= 5))

#part 2

library(ggplot2)

data(ToothGrowth)

ToothGrowth$dose <- factor(ToothGrowth$dose)

#Comparing the different doses and supplement types
p <- ggplot(ToothGrowth, aes(supp, len, fill = supp)) + geom_boxplot() + geom_point(color = "blue")
p + facet_grid(. ~ dose)

with(ToothGrowth, tapply(len, list(dose=dose, supp=supp), mean))

with(ToothGrowth, tapply(len, list(dose=dose, supp=supp), sd))


