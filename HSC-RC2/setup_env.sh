#!/usr/bin/env sh

weekly=w_2023_01
source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/${weekly}/loadLSST.bash
setup lsst_distrib -t ${weekly}
eups list lsst_distrib -s

# Same as in ctrl_bps_panda/python/lsst/ctrl/bps/panda/conf_example/setupUSDF.sh
export PANDA_CONFIG_ROOT=$HOME
export PANDA_URL_SSL=https://pandaserver-doma.cern.ch:25443/server/panda
export PANDA_URL=http://pandaserver-doma.cern.ch:25080/server/panda
export PANDAMON_URL=https://panda-doma.cern.ch
export PANDA_AUTH=oidc
export PANDA_VERIFY_HOST=off
export PANDA_AUTH_VO=Rubin

export PANDA_SYS=$CONDA_PREFIX
export IDDS_CONFIG=${PANDA_SYS}/etc/idds/idds.cfg.client.template

# WMS plugin
export BPS_WMS_SERVICE_CLASS=lsst.ctrl.bps.panda.PanDAService

# Proxy for S3DF
export HTTP_PROXY=http://atlsquid.slac.stanford.edu:3128
export https_proxy=http://atlsquid.slac.stanford.edu:3128
export http_proxy=http://atlsquid.slac.stanford.edu:3128
export HTTPS_PROXY=http://atlsquid.slac.stanford.edu:3128
export SQUID_PROXY=http://atlsquid.slac.stanford.edu:3128
