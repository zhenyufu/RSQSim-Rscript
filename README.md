# RSQSim-Rscript
* scripts for plotting rsqsim catalogs


### allRecur.R
* Finds recurrence interval of faults set inside


### combine.R
* Combine list files from two runs for the prob team 



### listAll.R
* Goes through the "/home/rsqsim-00/pubp/" to get path to all .out files 
* Returns a "myFileList" variable containing the paths


### myMain.R
* A lot of plots 


### restart_rsqsim.py
* Usage: `./restart_rsqsim.py <RSQSim source dir> <old directory> <old .in file> <restart name> <new maxT>`
* Example: `./restart_rsqsim.py /u/sciteam/scottcal/scratch/RSQSim/old-write-style/ ../UCERF3sigmahigh64/ ../UCERF3sigmahigh64/UCERF3sigmahigh64.in UCERFtest 1.8924e+12` 
