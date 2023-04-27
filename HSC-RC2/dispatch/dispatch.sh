#!/bin/env bash

# Look up at https://eups.lsst.codes/stack/src/tags/
export DATETAG="2023-03-16T08:22"


export DATASET="HSC_RC2"
export DATASET_REPO_URL="https://community.lsst.org/t/shared-gen3-data-repositories-ready-for-some-use/4845"
export RUN_ID="DM-38360"
export RUN_ID_URL="https://jira.lsstcorp.org/browse/DM-38360"
export VERSION_TAG="w_2023_11"

export JSON_FOLDER=/sdf/home/e/eiger/u/weekly_pipelines/HSC-RC2/dispatch/metrics_json/w_2023_11


ls -A1 $JSON_FOLDER | awk -v DATETAG="$DATETAG" '{print "dispatch_verify.py $JSON_FOLDER/" $1,"--ignore-blobs --ignore-lsstsw  --url https://squash-restful-api.lsst.codes --env=ldf --date-created "DATETAG":00Z"}' | bash

