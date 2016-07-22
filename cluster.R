cat = "/home/rsqsim-00/pub/longCats/UCERF3base35kyrs/eqs.UCERF3base.out"
#eqs = readEqs(cat)

K = 30
iter = 20
eMin = 7.7
eMax = 9
use = which(eqs$M <= eMax & eqs$M >= eMin & eqs$t0yr > 5000)

eX = eqs$t0yr[use]
eY = eqs$M[use]
X = matrix( c(eX, eY), nrow=length(eX), ncol=2, byrow = FALSE) 



###################### FUNCTION
findCt = function(X, centroids){

    idx = vector( mode = "numeric", length = nrow(X) )
    for ( i in 1:nrow(X) ){
        min = 999999999999
        index = -1

        for ( j in 1:nrow(centroids) ) {
            temp  = 0
            for ( k in 1:ncol(X) ) {
                temp = temp + ( X[i,k] - centroids[j,k] )^2;
            }
            if (temp < min){
                min = temp
                index = j 
            }
        }

        idx[i] = index
    }
    return (idx)
}


computeCt = function(X, idx, K){
    m = nrow(X)
    n = ncol(X)
    centroids = matrix( nrow = K, ncol = n)

    for (i in 1:K) {
        mySum = 0
        myCount = 0
        for (j in 1:m) {
            if( i == idx[j] ){
                mySum = mySum + X[j,]
                myCount = myCount + 1
            }
        }
        centroids[i, ] = mySum/myCount
    }

    return (centroids)

}

###################### START
print("***X")
print(X)


print("***initial centroids")
centroids = X[sample(nrow(X),size=K,replace=FALSE),]
idx = vector( mode = "numeric", length = nrow(X) )
print(centroids)


print("***running kmeans")
for(i in 1:iter){
    print(i)
    idx = findCt(X, centroids)
    centroids = computeCt(X, idx, K)
}


print("***results")
print(idx)
print(centroids)
x11()
plot(eX, eY, col=idx, type = "p", xlab = "Time (yrs)", ylab = "Magnitude", ylim=c(eMin, eMax), main = "lol")
   
###################### END
print("K: ")
print(K)

temp <- readLines("stdin", 1)



