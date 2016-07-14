#myPath = "/home/rsqsim-00/pub/"
#myFileList = list.files(myPath, pattern="eqs.*.out$", full.names=TRUE, recursive = TRUE)
#print(myFileList)
source("/home/scec-01/davidfu/listAll.R")

boolPlot3d = 0
eMin = 7
eMax = 9
tMin = 5000 
tMax = 30000


##################### START process each file
for ( myFile in myFileList){
    print("*****")
    print("Using:")
    print(myFile)


    eqs = readEqs(myFile) 
    tMax = max(eqs$t0yr)


    #print(eMin, eMax, tMin, tMax)


    print("*****")
    
    
   inRange = which(eqs$M >= eMin & eqs$M <= eMax & eqs$t0yr > tMin & eqs$t0yr < tMax )

    
    ssaf = which(eqs$fault$faultName %in% c("SanAndreas(BigBend)","SanAndreas(Coachella)rev", "SanAndreas(MojaveN)",
                                        "SanAndreas(MojaveS)", "SanAndreas(SanBernardinoN)","SanAndreas(SanBernardinoS)",
                                        "SanAndreas(SanGorgonioPass-GarnetHIll)"))

    #sjf = which()

    faultNames = ssaf                                               # To more easily change the list of fault patches used, change the value of faultNames
    euse = unique(eqs$eList[which(eqs$pList %in% faultNames)])	# List of the event ID's for those events on the SSAF
    use = euse[which(euse %in% inRange)]                            # Refined list of events within the time and magnitude ranges specified
    dt = diff(eqs$t0yr[use])                                        # recurrence intervals for those events (just the time between successive events)
    mri = mean(dt)                                                  # mean recurrence interval for those events
   

    x11()
    hist(dt, 25,freq = FALSE, xlim=c(0,max(dt)), main = myFile)                    # plots a histogram of the recurrence intervals
    abline(v= mri, col="blue")                                # plots a vertical line at the mean recurrence interval


    if(boolPlot3d){
        # To plot the patches you selected to check they are the ones you want
        col = rep(NA, length(eqs$fault$np))
        col[faultNames]= "red"
        x11()
        plotFault3d(eqs$fault, col = col, phi=40, lwd = 0.1, xlim = c(200,650), ylim = c(3600, 4000))   # xlim & ylim are set for S. California
    }


    # free memory
    rm(eqs)
}
#################### END
temp = readLines("stdin",1)
