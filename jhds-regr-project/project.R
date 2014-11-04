library(ggplot2)

data(mtcars)

pairs(mtcars, main = "mtcars data")

#based on the pairs results some of the variables need to be recast as factors

mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)


mtcars$displ.sqrt <- sqrt(mtcars$disp)

mpg.correlations <- cor(mtcars[sapply(mtcars, is.numeric)])[1,]
mpg.correlations
pairs(mtcars[sapply(mtcars, is.numeric)])

#for the first model we'll use a .75 cutoff for correlation we're choosing disp, wt and hp

par(mfrow = c(3, 2))
with(mtcars, boxplot(mpg~am, main = "Automatic(0) vs Manual(1)"))
with(mtcars, boxplot(mpg~cyl, main = "Cylinders"))
with(mtcars, boxplot(mpg~vs, main = "V- vs Standard engine"))
with(mtcars, boxplot(mpg~gear, main = "Gears"))
with(mtcars, boxplot(mpg~carb, main = "Carbureators"))
frame()
par(mfrow = c(1, 1))

#based on the assignment we are including am and based on seperation, cyl and vs. 
#There also seems to be some trend with carb

par(mfrow = c(4,1))

m1 <- lm(mpg ~ disp + wt + hp + am + cyl + vs + carb, data = mtcars)
summary(m1)

plot( mtcars$mpg,predict(m1, mtcars), col = mtcars$am)
abline(b = 1, a = 0)

#based on the siginificance of some of the variables we're goingto drop the carb variable
#although the disp variable has a high correlation to the outcome it appears that it is also strongly
#correlated to wt and hp so it can't necessarily be considered independent of the others and for that reason
#we'll also remove it from the model



m2 <- lm(mpg ~ wt + hp + am  + vs, data = mtcars)
summary(m2)

plot( mtcars$mpg,predict(m2, mtcars), col = mtcars$am)
abline(b = 1, a = 0)

m3 <- lm(mpg ~ wt + hp + am, data = mtcars)
summary(m3)

plot( mtcars$mpg,predict(m3, mtcars), col = mtcars$am)
abline(b = 1, a = 0)


m4 <- lm(mpg ~ wt*am + hp, data = mtcars)
summary(m4)

plot( mtcars$mpg,predict(m4, mtcars), col = mtcars$am)
abline(b = 1, a = 0)


library(grid)
library(ggplot2)
library(scales)
pushViewport(viewport(layout = grid.layout(1, 2)))
#plot indicates an interaction is important for the model
p1 <- qplot(wt, mpg, data = mtcars, color = am) + geom_smooth(aes(group=am), method="lm")
p1 <- p1 + guides(colour = FALSE)
p1 <- p1 +scale_y_continuous(limits = c(0, 40))

#shows there's an average affect
p2 <- qplot(hp, mpg, data = mtcars, color = am) + geom_smooth(aes(group=am), method="lm")
p2 <- p2 +scale_y_continuous(limits = c(0, 40))
                             
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
