# Set parameters 
source("/home/scec-01/davidfu/scatterplot3d/R/scatterplot3d.R")
#library(rgl)


#myFile = "/home/rsqsim-01/mbent/UCERF3test35kyrs/eqs.UCERF3base.out"
#myFile = "/home/rsqsim-00/pub/UCERF3base/eqs.UCERF3base.out"

myFiles = c("/home/rsqsim-00/pub/30kyrs/UCERF3rate/eqs.UCERF3rate.out",
"/home/rsqsim-00/pub/30kyrs/UCERF3state/eqs.UCERF3state.out")
myCol = rainbow(length(myFiles))

print("Using File:")
#print (myFile)


# Set plot bools
boolPlotEqs = 0

boolPlotTime = 0
myMag = c(7.6,7.7,7.9)
xMin = 0
xMax = 30000
yMax = 9

boolPlotHist = 0
hMin = 7.8

boolPlot3d = 1
dMin = 7
dMax = 9
dAngle = 40

boolPlotAll = 0
aMin = 7.6


# Functions
myPause = function() {
    cat("Paused, press Enter to cont ... " )
    temp <- readLines("stdin", 1)
}


myFilter = function(eqs,use){
    if (!is.null(use)) {
        eqs$t0 <- eqs$t0[use]
        eqs$t0yr <- eqs$t0yr[use]
        eqs$M <- eqs$M[use]
        eqs$M0 <- eqs$M0[use]
        eqs$x <- eqs$x[use]
        eqs$y <- eqs$y[use]
        eqs$z <- eqs$z[use]
        eqs$area <- eqs$area[use]
        eqs$dt <- eqs$dt[use]
        eqs$dbar <- eqs$dbar[use]
        Ntot <- length(use)
    }
    eqs$M[!is.finite(eqs$M)] <- NA
    return (eqs)
}



############################################# START

#eqs = readEqs(myFile)
load("/home/rsqsim-00/pub/longCats/combine340/UCERF3base_combine340kyrs.RData")

print( length(eqs$M) )
print( length(which(eqs$M > 7)) )


if(boolPlotEqs){
    plotEqs(eqs)
}


if(boolPlotTime){
    for (i in myMag){
        use = which(eqs$M > i)
        temp = myFilter(eqs,use)
        x11()
        plot(temp$t0yr, temp$M, type = "p", xlab = "Time (yrs)", ylab = "Magnitude", xlim=c(xMin,xMax), ylim=c(i, yMax), main = i)
    }
}


if(boolPlotHist){
 
    x11()
    hist(eqs$M, breaks = 200, xlab = "magnitude", ylab = "amount", main = "hist")
    #myDensity(eqs$M)
    
    use = which(eqs$M > hMin & eqs$t0yr > 5000)
    temp = myFilter(eqs,use)
    x11()
    hist(temp$M, breaks = 200, xlab = "magnitude", ylab = "amount", main = "hist")
}


if(boolPlot3d){
    use = which(eqs$M > dMin & eqs$M < dMax & eqs$t0yr > 5000)
    e = myFilter(eqs,use) 
    x11() 
x = e$M
x_norm = (x - min(x)) / (max(x) - min(x))
col_fun <- colorRamp(c("blue", "red"))
rgb_cols <- col_fun(x_norm)
cols <- rgb(rgb_cols, maxColorValue = 256)


    scatterplot3d(e$area, e$t0yr, e$z, color = cols, pch = 16, angle = dAngle, main=dMin,  type="p")
    #highlight.3d=TRUE,
    #plot3d(temp$t0yr, temp$M, temp$z, col="red", size=3)
}

if(boolPlotAll){

    use = which(eqs$M > aMin & eqs$t0yr > 5000)
    temp = myFilter(eqs,use)
    d = density(temp$M)  
    x11()
    plot(d, main=aMin)
    for (i in 1:length(myFiles)){
        print(myFiles[i])
        print(myCol[i])
        e = readEqs(myFiles[i])
print( length(e$M) )
print( length(which(e$M > 7)) )

        temp = myFilter(e,use)
        d = density(temp$M)
        lines (approx(d, xout=seq_along(d))$y, col = myCol[i])
        rm(e)
    }

    
  

}
############################################## END


myPause()
print("End process")


                                                 
