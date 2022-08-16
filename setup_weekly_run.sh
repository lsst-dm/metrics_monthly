# change these numbers every run
NUMBER='32'
WEEKLY='2022_32'
TICKETNUM='34983'
DATETAG='2022-05-26T08:26'

# setup directory for weekly run
DIR=w_${WEEKLY}
echo Copying to $DIR
mkdir -p $DIR
cp  weekly_templates/* $DIR/
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
export weekly=w_${WEEKLY}
# source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/${weekly}/loadLSST.bash 
# setup lsst_distrib

# setup PanDA env. Will be a simple step when the deployment of PanDA is fully done.
export PANDA_CONFIG_ROOT=$HOME
export PANDA_URL_SSL=https://pandaserver-doma.cern.ch:25443/server/panda
export PANDA_URL=http://pandaserver-doma.cern.ch:25080/server/panda
export PANDA_AUTH=oidc
export PANDA_VERIFY_HOST=off
export PANDA_AUTH_VO=Rubin

# IDDS_CONFIG path depends on the weekly version 
idds_cfg_template=/cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/${weekly}/conda/envs/lsst-scipipe-*/etc/idds/idds.cfg.client.template
export IDDS_CONFIG=`echo $idds_cfg_template |  cut -d ' ' -f1`
