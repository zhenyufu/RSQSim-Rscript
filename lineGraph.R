source("/home/scec-01/davidfu/.Rprofile")

#eqs = readEqs("/home/rsqsim-01/mbent/baseRuns/UCERF3base35kyrs/eqs.UCERF3base.out")
#eqs = readEqs("/home/rsqsim-01/mbent/baseRuns/UCERF3base80kyr-125kyr/eqs.UCERF3base80kyr-125kyr.out")
#eqs = readEqs("/home/scec-01/davidfu/UCERF3sigmahigh/eqs.UCERF3sigmahigh.out")
#eqs = readEqs("/home/rsqsim-00/sortega4/eqs.UCERF3rate.out")
#eqs = readEqs("/home/rsqsim-02/hmlopez/eqs.UCERF3state.out")
load("/home/rsqsim-01/mbent/baseRuns/UCERF3base_125kyrs.RData")

maxYr <- 125000
increment <- 500
currYr <- 0
count <- 0
div <- (maxYr/increment)

yrs <- vector("list", div)
freq <- vector("list", div)

while(currYr < maxYr){
	lst = which(eqs$M > 7 & eqs$t0yr > currYr & eqs$t0yr < (currYr+increment))
	len = length(lst)

	count <- count + 1
	currYr <- currYr + increment

	freq[count] <- len
	yrs[count] <- currYr
		
}

print(freq)
print(yrs)

plot(yrs, freq, type="b")
