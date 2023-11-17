#!/usr/bin/env sh

weekly=w_2023_32
source /sdf/group/rubin/sw/tag/${weekly}/loadLSST.sh
setup lsst_distrib -t ${weekly}

#custom setups?
eups list -s | grep LOCAL

# Same as in ctrl_bps_panda/python/lsst/ctrl/bps/panda/conf_example/setupUSDF.sh
export PANDA_CONFIG_ROOT=$HOME/.panda
export PANDA_URL_SSL=https://pandaserver-doma.cern.ch:25443/server/panda
export PANDA_URL=http://pandaserver-doma.cern.ch:25080/server/panda
export PANDAMON_URL=https://panda-doma.cern.ch
export PANDA_AUTH=oidc
export PANDA_VERIFY_HOST=off
export PANDA_AUTH_VO=Rubin

export PANDA_SYS=$CONDA_PREFIX
export IDDS_CONFIG=${PANDA_SYS}/etc/idds/idds.cfg.client.template
export no_proxy=.slac.stanford.edu,.cern.ch
export NO_PROXY=.slac.stanford.edu,.cern.ch

# WMS plugin
export BPS_WMS_SERVICE_CLASS=lsst.ctrl.bps.panda.PanDAService

# Check PanDA authentication
panda_auth status
