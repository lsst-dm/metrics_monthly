#!/bin/env bash
# Look up at https://eups.lsst.codes/stack/src/tags/
export DATETAG="2022-12-14T14:45"
export DATASET="DC2_test-med-1"
export DATASET_REPO_URL="https://community.lsst.org/t/shared-gen3-data-repositories-ready-for-some-use/4845"
export RUN_ID="DM-37822"
export RUN_ID_URL="https://jira.lsstcorp.org/browse/DM-37822"
export VERSION_TAG="w_2023_06"

export SQUASH_USER=
export SQUASH_password=
ls -A1 /sdf/group/rubin/sandbox/eiger/metrics_json/ |grep verify.json| awk -v DATETAG="2023-02-09T10:13" '{print "dispatch_verify.py /sdf/group/rubin/sandbox/eiger/metrics_json/" $1,"--ignore-blobs --ignore-lsstsw  --url https://squash-restful-api.lsst.codes --env=ldf --date-created "DATETAG":00Z"}' | bash
