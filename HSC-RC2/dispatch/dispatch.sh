#!/bin/env bash

# Look up at https://eups.lsst.codes/stack/src/tags/
export DATETAG="2022-11-24T08:04"


export DATASET="HSC_RC2"
export DATASET_REPO_URL="https://community.lsst.org/t/shared-gen3-data-repositories-ready-for-some-use/4845"
export RUN_ID="DM-37089"
export RUN_ID_URL="https://jira.lsstcorp.org/browse/DM-37089"
export VERSION_TAG="w_2022_48"

export SQUASH_USER=verification
export SQUASH_password=2DfjXgWBL964NVDFRby3

export JSON_FOLDER=/fs/ddn/sdf/group/rubin/sandbox/eiger/metrics_json/w_2022_48/
ls -A1 $JSON_FOLDER | awk -v DATETAG="$DATETAG" '{print "dispatch_verify.py $JSON_FOLDER/" $1,"--ignore-blobs --ignore-lsstsw  --url https://squash-restful-api.lsst.codes --env=ldf --date-created "DATETAG":00Z"}' | bash

