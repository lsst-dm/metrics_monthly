#if [ -z "$EUPSTAG" ]; then
#    export EUPSTAG=`/usr/bin/date -d "+3days" +w_%Y_%U`    
#fi
EUPSTAG=w_WEEKLY
lsstsw_root=/software/lsstsw/stack
#lsstsw_root=/software/lsstsw/stack_20210520

echo ${EUPSTAG}
source /opt/rh/devtoolset-8/enable
source ${lsstsw_root}/loadLSST.bash
setup lsst_distrib -t ${EUPSTAG}

export OMP_NUM_THREADS=1

auth_path=/home/brendal4/.lsstauth

# Postgres
export LSST_DB_AUTH=$auth_path/db-auth-rc.yaml
#export DAF_BUTLER_CONFIG_PATH=`pwd`
export PGPASSFILE=$auth_path/.pgpass

# HTCondor API
export PYTHONPATH=$PYTHONPATH:/usr/lib64/python3.6/site-packages

