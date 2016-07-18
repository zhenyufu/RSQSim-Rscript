cat1 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyrs/eqs.UCERF3base.out"
cat2 = "/home/rsqsim-00/pub/longCats/UCERF3base35kyr-80kyr/eqs.UCERF3base35kyr-80kyr.out"
out1 = "UCERF3base_75yrs.RData"
out2 = "UCERF3base_75yrs.eList"
out3 = "UCERF3base_75yrs.dList"
out4 = "UCERF3base_75yrs.tList"
out5 = "UCERF3base_75yrs.pList"


eqFiles = c(cat1,cat2)
print("start")
eqs = readAndCombineEqfiles(eqFiles)

print("start save")
#save(eqs, file = out1)
print(str(eqs))

print("start save list e")
save(list = eqs$eList, file = out2)

print("start save list d")
save(list = eqs$dList, file = out3)

print("start save list t")
save(list = eqs$tList, file = out4)

print("start save list p")
save(list = eqs$pList, file = out5)

