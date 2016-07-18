cat1 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyrs/eqs.UCERF3base.out"
cat2 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyr-80kyr/eqs.UCERF3base35kyr-80kyr.out"
outName = "UCERF3base_80yrs"


out1 = paste(outName, ".RData", sep="")
out2 = paste(outName, ".eList", sep="")
out3 = paste(outName, ".dList", sep="")
out4 = paste(outName, ".tList", sep="")
out5 = paste(outName, ".pList", sep="")


eqFiles = c(cat1,cat2)
print("start")
eqs = readAndCombineEqfiles(eqFiles)


print("start save")
#save(eqs, file = out1)
#print(str(eqs))


print("start save list e")
writeBin(eqs$eList, out2, size=4, endian = "big")

print("start save list d")
writeBin(eqs$dList, out3, size=8, endian = "big")

print("start save list t")
writeBin(eqs$tList, out4, size=8, endian = "big")

print("start save list p")
writeBin(eqs$pList, out5, size=4, endian = "big")

