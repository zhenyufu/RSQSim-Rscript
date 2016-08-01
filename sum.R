# finds the average number of large events per "increment" years 

source("/home/scec-01/davidfu/.Rprofile")

eqs = readEqs("/home/rsqsim-00/pub/sensitivityTesting/sensitive1/eqs.UCERF3test35kyrs.out")
#load("/home/rsqsim-00/pub/longCats/combine_rate2_90kyrs/combine_rate2_90kyrs.RData")

maxYr <- 30000
increment <- 1000
currYr <- 0
count <- 0
#div <- (maxYr/increment)

sum <- 0

while(currYr < maxYr){
	lst = which(eqs$M > 7 & eqs$t0yr > currYr & eqs$t0yr < (currYr+increment))
	len = length(lst)
	
	count <- count + 1
	currYr <- currYr + increment

	sum <- (sum + len)
}

sum <- (sum/count)
print(sum)
