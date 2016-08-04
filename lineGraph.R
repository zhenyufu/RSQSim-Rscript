# source for the .Rprofile
source("/home/scec-01/davidfu/.Rprofile")

# either read the earthquakes in or load the .RData file
#eqs = readEqs("/home/rsqsim-01/mbent/baseRuns/UCERF3base35kyrs/eqs.UCERF3base.out")
load("/home/rsqsim-01/mbent/baseRuns/UCERF3base_125kyrs.RData")

# change the max year depending on the length of the catalog
maxYr <- 125000
increment <- 500
currYr <- 0
count <- 0
div <- (maxYr/increment)


yrs <- vector("list", div)			# list of years for plotting
freq <- vector("list", div)			# list of frequencies of events per time period

# loop through entire list of events in chunks of time
while(currYr < maxYr){

	# find the number of large events during current time period
	lst = which(eqs$M > 7 & eqs$t0yr > currYr & eqs$t0yr < (currYr+increment))
	len = length(lst)

	count <- count + 1
	currYr <- currYr + increment

	# record number of events and time period
	freq[count] <- len
	yrs[count] <- currYr
		
}

# plot line graph
plot(yrs, freq, type="b")
