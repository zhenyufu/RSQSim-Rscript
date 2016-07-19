
cat1 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyrs/eqs.UCERF3base.out"
cat2 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyr-80kyr/eqs.UCERF3base35kyr-80kyr.out"
outName = "UCERF3base_80yrs"


out1 = paste(outName, ".RData", sep="")
out2 = paste(outName, ".eList", sep="") # int
out3 = paste(outName, ".pList", sep="") # int
out4 = paste(outName, ".dList", sep="") # double
out5 = paste(outName, ".tList", sep="") # double

eqFiles = c(cat1,cat2)
print("start")
eqs = readAndCombineEqfiles(eqFiles)


### 1 .RData
print("start save")
print(str(eqs))
#save(eqs, file = out1)


### 2 e
print("start save list e")
x = as.integer(eqs$eList)
con = file(out2,"wb")
writeBin(x, con)
close(con)


### 3 p
print("start save list p")
x = as.integer(eqs$pList)
con = file(out3,"wb")
writeBin(x, con)
close(con)


### 4 d
print("start save list d")
x = as.double(eqs$dList)
con = file(out4,"wb")
writeBin(x, con)
close(con)


### 5 t
print("start save list t")
x = as.double(eqs$tList)
con = file(out5,"wb")
writeBin(x, con)
close(con)

######## test
print("test.....")
print(readBin(file(out2, "rb"), what = "integer", n=10))
print(readBin(file(out3, "rb"), what = "integer", n=10))
print(readBin(file(out4, "rb"), what = "double", n=10))
print(readBin(file(out5, "rb"), what = "double", n=10))
