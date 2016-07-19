#!/usr/bin/env python

import sys
import os
import shutil

if len(sys.argv)<6:
	print "Usage: %s <RSQSim source dir> <old directory> <old .in file> <restart name> <new maxT>" % sys.argv[0]
	sys.exit(1)

rsqsim_dir = sys.argv[1]
old_dir = sys.argv[2]
old_in_filename = sys.argv[3]
restart_name = sys.argv[4]
maxT = float(sys.argv[5])

#Create new directory if doesn't exist
if not os.path.exists(restart_name):
	os.mkdir(restart_name)

#Read in *.in file as key/value pairs
print "Reading old input file %s." % old_in_filename
params = dict()
with open(old_in_filename, "r") as fp_in:
	for line in fp_in.readlines():
		pieces = line.split("=")
		params[pieces[0].strip()] = pieces[1].strip()
	fp_in.close()

#Create and run R script to generate init files
print "Creating R script to generate new init files."
with open("restart.R", "w") as fp_out:
	#fp_out.write('source("%s/RSQSimPostProcess/R/")\n')
	fp_out.write('source("%s/RSQSimPostProcess/R/readEqs.R")\n' % (rsqsim_dir))
        fp_out.write('source("%s/RSQSimPostProcess/R/mkInitTauSigmaThetaSlipSpeed.R")\n' % (rsqsim_dir))
	fp_out.write('source("%s/RSQSimPostProcess/R/readFault.R")\n' % (rsqsim_dir))
	fp_out.write('source("%s/RSQSimPostProcess/R/cross.R")\n' % (rsqsim_dir))
        fp_out.write('source("%s/RSQSimPostProcess/R/isFaultGrid.R")\n' % (rsqsim_dir))
        fp_out.write('source("%s/RSQSimPostProcess/R/isFaultGridNew.R")\n' % (rsqsim_dir))
        fp_out.write('source("%s/RSQSimPostProcess/R/readNeighbors.R")\n' % (rsqsim_dir))
        fp_out.write('source("%s/RSQSimPostProcess/R/readFaultVal.R")\n' % (rsqsim_dir))
	fp_out.write('eqs = readEqs("%s/eqs.%s.out")\n' % (old_dir, params['outFnameInfix']))
	fp_out.write('tmp = mkInitTauSigmaThetaSlipSpeed(eqs, Inf, writeTau = "final", writeSlipSpeed = 0, initTauFile="%s/%s.initTau", initSigmaFile="%s/%s.initSigma", initThetaFile = "%s/%s.initTheta")\n' % (restart_name, restart_name, restart_name, restart_name, restart_name, restart_name))
	fp_out.write('Tstart = format(tmp$t, digits=22)\n')
	#Write Tstart to a file
	fp_out.write('write(Tstart, file="Tstart.out")\n')
	fp_out.write('pin = scan(file="%s/%s")\n' % (old_dir, params['pinnedFname']))
	fp_out.write('''system("grep Eliminating %s/*stderr | awk '{print $4}' > %s/pin.locked")\n''' % (old_dir, old_dir))
	#check *.e file also, append
	fp_out.write('''system("grep Eliminating %s/*.e | awk '{print $4}' >> %s/pin.locked")\n''' % (old_dir, old_dir))
	fp_out.write('pin2 = scan(file="%s/pin.locked")\n' % (old_dir))
	fp_out.write('pin[pin2] = 1\n')
	fp_out.write('write(pin, file="%s/%s.pin", ncol=1)\n' % (restart_name, restart_name))
	fp_out.flush()
	fp_out.close()

#Run R script, check return code
print "Running R script."
rc = os.system("R CMD BATCH restart.R")
#rc = os.system("Rscript restart.R")
if rc!=0:
	print "Error %d when running R script restart.R, aborting." % (rc)
	print "Check restart.Rout file for more details."
	sys.exit(2)

#Get Tstart from file
with open("Tstart.out", "r") as fp_in:
	tstart = float(fp_in.readline())
	fp_in.close()

#Change maxT, outFnameInfix,  initTauFname, initSigmaFname, initThetaFname, pinnedFname, Tstart
print "Changing parameters."
params['tStart'] = tstart
params['maxT'] = maxT
params['outFnameInfix'] = restart_name
params['initTauFname'] = "%s.initTau" % (restart_name)
params['initSigmaFname'] = "%s.initSigma" % (restart_name)
params['initThetaFname'] = "%s.initTheta" % (restart_name)

#Copy in neighborFname, faultFname, KZeroFname
print "Copying in files."
shutil.copy("%s/%s" % (old_dir, params['neighborFname']), "%s/%s" % (restart_name, params['neighborFname']))
shutil.copy("%s/%s" % (old_dir, params['faultFname']), "%s/%s" % (restart_name, params['faultFname']))
shutil.copy("%s/%s" % (old_dir, params['KZeroFname']), "%s/%s" % (restart_name, params['KZeroFname']))

#Write new *.in file
print "Writing new input file."
new_in_filename = os.path.join(restart_name, "%s.in" % (restart_name))
with file(new_in_filename, "w") as fp_out:
	for key in sorted(params.keys()):
		fp_out.write("%s = %s\n" % (key, params[key]))
	fp_out.flush()
	fp_out.close()


