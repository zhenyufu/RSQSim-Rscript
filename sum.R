# finds the average number of large events per "increment" years 

# source for the .Rprofile
source("/home/scec-01/davidfu/.Rprofile")

# either read in the earthquakes from the catalog or load the .RData file
eqs = readEqs("/home/rsqsim-00/pub/sensitivityTesting/sensitive1/eqs.UCERF3test35kyrs.out")
#load("/home/rsqsim-00/pub/longCats/combine_rate2_90kyrs/combine_rate2_90kyrs.RData")

# change the max number of years depending on the length of the catalog
maxYr <- 30000
increment <- 1000 			# average value per "increment" years
currYr <- 0
count <- 0

sum <- 0

while(currYr < maxYr){
	lst = which(eqs$M > 7 & eqs$t0yr > currYr & eqs$t0yr < (currYr+increment))
	len = length(lst)
	
	count <- count + 1
	currYr <- currYr + increment

	sum <- (sum + len)
}

# calculate the average 
sum <- (sum/count)
print(sum)
