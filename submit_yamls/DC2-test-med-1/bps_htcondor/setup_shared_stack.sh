#!/usr/bin/env sh

#weekly=w_2023_45
daily=d_2023_11_11
source /sdf/group/rubin/sw/tag/${daily}/loadLSST.bash
setup lsst_distrib -t ${daily}

#custom setups?
eups list -s | grep LOCAL

# WMS plugin
export BPS_WMS_SERVICE_CLASS=lsst.ctrl.bps.htcondor.HTCondorService
