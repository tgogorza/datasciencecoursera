lambda <- 0.2
sd <- 1/lambda
var <- sd^2
mean <- 1/lambda
nsim <- 1000
n <- 40

#Simulation (1000 simulations of 40 samples drawn from an exponential distribution)
simulations <- matrix(rexp(nsim * n,lambda), nsim)

#1. Sample mean vs. Theoretical mean
mns <- apply(simulations, 1, mean)
samplemean <- mean(mns)
mean
samplemean

par(mfrow=c(2,1))
hist(simulations,breaks = 50, xlab="Sample value", main="Theoretical mean")
abline(v = mean, col = "blue", lwd = 1)
text(mean+3, 5000 , paste("theoretical mean:", mean), pos = 4, col="blue")
hist(simulations,breaks = 50, xlab="Sample value", main="Sample mean")
abline(v = samplemean, col = "red", lwd = 1)
text(samplemean+3, 5000 , paste("sample mean:", samplemean), pos = 4, col="red")

#2. Sample variance vs. Theoretical variance
vars <- apply(simulations, 1, var) 
samplevar <- mean(vars)
var
samplevar
hist(vars)

#3. 
par(mfrow=c(2,1))
hist(rexp(nsim * n,lambda),breaks=50)
hist(mns,breaks=50)
