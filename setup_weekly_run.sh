# change these numbers every run
export NUMBER='32'
export WEEKLY='2022_32'
export TICKETNUM='STEP1-RUNTIME-TEST'
export DATETAG='2022-08-25T04:02'

# setup directory for weekly run
DIR=step1-runtime-test #w_${WEEKLY}
echo Copying to $DIR
mkdir -p $DIR
cp  weekly_templates/* $DIR/
# it seems like the submit directory was once created in the template folder
# via submitting a template rather than a weekly yaml file. if the submit 
# directory should be copied, make sure to use cp -r and mv to rename directory
# structure.
sed -i "s/NUMBER/${NUMBER}/g" $DIR/*
sed -i "s/WEEKLY/${WEEKLY}/g" $DIR/*
sed -i "s/TICKETNUM/${TICKETNUM}/g" $DIR/*

# setup metrics dispatch directory
cd $DIR
mkdir -p metrics_dispatch
mv dispatch.sh make_json.sh metrics_dispatch/
sed -i "s/TICKETNUM/${TICKETNUM}/g" ./metrics_dispatch/*
sed -i "s/WEEKLY/${WEEKLY}/g" ./metrics_dispatch/*
sed -i "s/DATETAG/${DATETAG}/g" ./metrics_dispatch/*

# setup Rubin env
#export weekly=w_${WEEKLY}
source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_${WEEKLY}/loadLSST.bash 
setup lsst_distrib

# setup PanDA env. Will be a simple step when the deployment of PanDA is fully done.
export PANDA_CONFIG_ROOT=$HOME
export PANDA_URL_SSL=https://pandaserver-doma.cern.ch:25443/server/panda
export PANDA_URL=http://pandaserver-doma.cern.ch:25080/server/panda
export PANDA_AUTH=oidc
export PANDA_VERIFY_HOST=off
export PANDA_AUTH_VO=Rubin

# IDDS_CONFIG path depends on the weekly version 
idds_cfg_template=/cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_${WEEKLY}/conda/envs/lsst-scipipe-*/etc/idds/idds.cfg.client.template
export IDDS_CONFIG=`echo $idds_cfg_template |  cut -d ' ' -f1`
