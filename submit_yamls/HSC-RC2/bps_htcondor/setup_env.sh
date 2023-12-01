#!/usr/bin/env sh

weekly=w_2023_43
source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/${weekly}/loadLSST.bash
setup lsst_distrib -t ${weekly}

#custom setups?
eups list -s | grep LOCAL

# WMS plugin
export BPS_WMS_SERVICE_CLASS=lsst.ctrl.bps.htcondor.HTCondorService
