export DATASET="HSC_RC2"
export DATASET_REPO_URL="https://community.lsst.org/t/shared-gen3-data-repositories-ready-for-some-use/4845"
export RUN_ID="DM-TICKETNUM"
export RUN_ID_URL="https://jira.lsstcorp.org/browse/DM-TICKETNUM"
export VERSION_TAG="w_WEEKLY"
ls -A1 json/ | awk '{print "dispatch_verify.py json/" $1,"--ignore-blobs --ignore-lsstsw --env=ldf --date-created DATETAG:00Z"}' | bash

