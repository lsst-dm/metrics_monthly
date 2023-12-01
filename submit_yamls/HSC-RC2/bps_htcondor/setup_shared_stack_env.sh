#!/usr/bin/env sh

weekly=w_2023_32
source /sdf/group/rubin/sw/tag/${weekly}/loadLSST.sh
setup lsst_distrib -t ${weekly}

#custom setups?
eups list -s | grep LOCAL

# WMS plugin
export BPS_WMS_SERVICE_CLASS=lsst.ctrl.bps.htcondor.HTCondorService


