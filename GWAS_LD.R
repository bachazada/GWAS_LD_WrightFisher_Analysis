#### exercise 1 ####

rm(list=ls())
require(snpStats)
require(hexbin)

load("./tutorial_3_data/snps_10.dat")
ls()
browseVignettes("snpStats")
show(snps.10)


sample.qc <- row.summary(snps.10)
str(sample.qc)
summary(sample.qc)


use <- sample.qc$Heterozygosity>0   #LOH can be caused by degradation, deletion, due to an imbalance rearrangement, gene conversion, mitotic recombination, or loss of a whole chromosome [inaudible].
snps.10 <- snps.10[use, ]
subject.support <- subject.support[use, ]

if.case <- subject.support$cc == 1
if.control <- subject.support$cc == 0

tests <- single.snp.tests(cc, data = subject.support, snp.data = snps.10)

head(subject.support)
subject.support$cc
subject.support$stratum

str(snps.10)

position <- snp.support[, "position"]

p1 <- p.value(tests, df=1)

p1.ordered <- order(p1, decreasing = FALSE)
p1.new <- p1[p1.ordered]
p1.ordered[1:3]
str(snp.support)

snp.support$position[p1.ordered[1:3]]
head(p1.new)

?hexVP.abline
pdf("manhatten.pdf")
fit <- hexbin(position, -log10(p1), xbin=50)
p <- plot(fit)
hexVP.abline(hvp = p$plot.vp, h = -log10(0.05/28501))
dev.off()

str(snps.10)
dim(snps.10@.Data)

snps.10@.Data[1:5,1:5]

subject.support$stratum=="CEU"

#ls()
#str(snps.10)


#### exercise 2 ####

ld.snps.10.CEU <- ld(snps.10[subject.support$stratum=="CEU",], stats=c("D.prime", "R.squared"), depth=2)
ld.snps.10.JPT_CHB <- ld(snps.10[subject.support$stratum=="JPT+CHB",], stats=c("D.prime", "R.squared"), depth=2)

str(ld.snps.10.CEU$D.prime)

matrix(ld.snps.10.CEU$D.prime)[1:5,1:5]

pdf("CEU.pdf")
image(ld.snps.10.CEU$D.prime, lwd=0)
dev.off()

pdf("JPT_CHB.pdf")
image(ld.snps.10.JPT_CHB$D.prime, lwd=0)
dev.off()

spectrum <- rainbow(10, start=0, end=1/6)[10:1]
use <- 75:274
length(use)
pdf("CEU_JPT_CHB.pdf")
image(ld.snps.10.JPT_CHB$D.prime[use,use], lwd=0)
#image(ld.snps.10.CEU$D.prime[use,use], lwd=0)
#image(ld.snps.10.JPT_CHB$D.prime[use,use], lwd=0, cuts=9, col.regions=spectrum, colorkey=TRUE)
dev.off()

#### exercise 3 ####

# data.frame to be filled
wf_df <- data.frame()

# effective population sizes
sizes <- c(50, 100, 1000, 5000)

# starting mutant frequencies
starting_p <- c(.01, .1, .5, .8)

# number of generations
n_gen <- 100

# number of replicates per simulation
n_reps <- 10

# run the simulations
N <- 100 
p <- 0.1
pdf("hist.pdf")
hist(X)
dev.off()
for(N in sizes){
  for(p in starting_p){
    p0 <- p
    for(j in 1:n_gen){
      X <- rbinom(n_reps, N, p)
      p <- X / N
      rows <- data.frame(replicate = 1:n_reps, N = rep(N, n_reps), 
                         gen = rep(j, n_reps), p0 = rep(p0, n_reps), 
                         p = p)
      print(rows)
      wf_df <- rbind(wf_df, rows)
    }
  }
}


library(ggplot2)
# plot it up!
p <- ggplot(wf_df, aes(x = gen, y = p, group = replicate)) +
  geom_path(alpha = .5) + facet_grid(N ~ p0) + guides(colour=FALSE)

pdf("WF.pdf")
p
dev.off()
??ggplot



