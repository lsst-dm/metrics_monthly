# Metrics dispatch
* Obtain SQUASH user and password from the SQUASH admin.
* Create the directory where the json files will be stored. Update the scripts for the directory.
* Set up the `lsst_distrib` stack
* `sbatch make_json.sl`
* `sbatch dispatch.sl`
* After the dispatch is done, notify the SQUASH admin to synchronize the SQuaSH DB with InfluxDB.
* Then new metrics should show up in Rubin's [Chronograf Dashboard](https://chronograf-demo.lsst.codes/sources/2/dashboards/75?refresh=Paused&tempVars%5Bbutler_gen%5D=Gen3&tempVars%5Bdataset%5D=DC2_test-med-1&tempVars%5Btime_start%5D=One%20year%20prior%20to%20end&tempVars%5Btract%5D=3828&lower=now%28%29%20-%2015m)
* Reference: [S3DF batch compute document](https://s3df.slac.stanford.edu/public/doc/#/batch-compute)
