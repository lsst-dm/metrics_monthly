#!/bin/env bash

# Look up at https://eups.lsst.codes/stack/src/tags/
export DATETAG="2022-09-01T07:51"


export DATASET="HSC_RC2"
export DATASET_REPO_URL="https://community.lsst.org/t/shared-gen3-data-repositories-ready-for-some-use/4845"
export RUN_ID="DM-36356"
export RUN_ID_URL="https://jira.lsstcorp.org/browse/DM-36356"
export VERSION_TAG="w_2022_40"

export SQUASH_USER=
export SQUASH_password=

ls -A1 json/ | awk -v DATETAG="$DATETAG" '{print "dispatch_verify.py json/" $1,"--ignore-blobs --ignore-lsstsw  --url https://squash-restful-api.lsst.codes --env=ldf --date-created "DATETAG":00Z"}' | bash

