# DRP Monthly Metrics Reprocessing: An introduction
These collected submit yamls are intended for use by Rubin campaign management pilots at USDF at SLAC. In this folder, one will find a collection of tests, and then submit yamls organized by campaign. These currently include the two campaigns being used for monthly evaluation of DRP metrics [see reference page for details and output from these processing efforts]( https://confluence.lsstcorp.org/display/DM/Monitoring+DRP+Pipeline+Performance) -- these are **[HSC-RC2](https://dmtn-088.lsst.io)** and **DC2 test-med-1**. These runs are both broken up into processing steps, which are detailed in [`drp_pipe`](https://github.com/lsst/drp_pipe/tree/main) and necesitated by output data products and smallest units of parallelization. The pipeline steps are not necessarily run in numerical order; the docstrings on `drp_pipe` should for the time being be taken as the source of truth for which steps must be run in which order. As a general rule, productions complete faster when every step is run as soon as possible.
## Submitting reprocessing yaml files to the USDF
This repository contains yaml files which can be submitted to a high-throughput compute workflow management system (WMS) on the USDF for medium-sized processing runs.

In each campaign folder one will find yamls to be submitted with [BPS](https://pipelines.lsst.io/modules/lsst.ctrl.bps/index.html) to either [PanDA](https://pipelines.lsst.io/modules/lsst.ctrl.bps.panda/index.html) or [HTCondor](https://pipelines.lsst.io/modules/lsst.ctrl.bps.htcondor/index.html).

In these folders one will also find two setup files. These files set up the lsst stack ([the process of which can be done in many ways](https://developer.lsst.io/usdf/stack.html)) and also set a number of relevant parameters for the WMS. In either case, the basic usage for these files is to `source <setup_file>.sh` and then run `bps submit <yaml_file>.yaml` (I prefer the incantation `bps submit <yaml_file>.yaml &> logs/<yaml_file>.log`).

In the case of HTCondor workflows, one must also allocate compute nodes, best done using [`allocateNodes.py`](https://developer.lsst.io/usdf/batch.html) (the incantation I have been using for these workflows is `allocateNodes.py -v --dynamic -n <number of nodes> -c <number of cores> -m 4-00:00:00 -q roma,milano -g 3600 s3df`). A Campaign Management pilot should be able to use order ~3000 nodes for a production.

When the user runs `bps submit`, a submit directory is created in the active directory with many useful outputs from the run. To track what occurred during the run, use `bps report` and the `--id` option (PanDA workflows will use the request ID here; HTCondor workflows will use the slurm id or the directory marked as "submitting from" by the output of the `submit`).

For post-run information on quanta, errors and their outcomes, as of w_2023_46, one may also use `pipetask report` to investigate (type `pipetask report -h` in the terminal with the stack set up for details).

Finally, these are not the only methods for submitting metrics monthly processing to the USDF. the prototype [cm_prod](https://github.com/lsst-dm/cm_prod) and [cm_tools](https://github.com/lsst-dm/cm_tools), and the future [cm_service]() packages are designed for further grouping, automation, and management of processing runs including but not limited to these. For more information on using the `cm_tools` prototype, see [CM Tools Usage Notes](https://confluence.lsstcorp.org/display/DM/CM+Tools+usage+notes).
## User permissions and groups
All PanDA workflows are launched by the user `lsstsvc1`. To set this up, it is necessary to make a PanDA account (contact #rubinobs-panda-support on the LSSTC slack for details). [Here is more information about workflows with panda](https://panda.lsst.io/index.html).

Currently, individual user accounts do not have the permissions to write to protected directories like `HSC/runs/RC2` or `2.2i/runs/test-med-1`. This is an issue for running HTCondor productions because these are run by the user by default. In future, we are talking about making a `rubin_pilots` group, but for the meantime there are two possible workarounds for pilots:
* Run the initial step (Step 1, currently) with PanDA, so that `lsstsvc1` makes the directory. Then, proceed with HTCondor for subsequent steps.
* Run the production with HTCondor as the `lsstsvc1` user. From KT on the #ops-cm-team slack:
  > To become lsstsvc1, pilots should do the following:
  > * ssh to `s3dflogin.slac.stanford.edu` using your standard credentials.
  > * Run `kinit` and provide your password.
  > * ssh to lsstsvc1@rubin-devl.
  > Please be careful about how you use this account, as it does have elevated access privileges.

The shared directory `/sdf/group/rubin/shared/campaigns` has been created to store any necessary ingredients for active campaigns, and it has been requested that pilots run out of that directory so that their campaigns can be picked up by others if need be.
## Dispatching metrics to Sasquatch
Metrics and plots are generated in the `analysis_tools` workflow that makes up Step 8. By default, the yamls provided here for Step 8 should dispatch metrics to Sasquatch and be visible on the [Chronograf dashboard](https://usdf-rsp-dev.slac.stanford.edu/chronograf/sources/1/dashboards/6?refresh=Paused&tempVars%5Btime_start%5D=One%20year%20prior%20to%20end&tempVars%5Btract%5D=9813&tempVars%5Bdataset%5D=HSC%2FRC2&lower=now%28%29%20-%2015m). These plots and metrics are the main deliverable of the DRP metrics monthly campaigns. If this dispatch fails, a good fallback option is to re-run Step 8 (JUST STEP 8) on the head nodes with `pipetask run`:

For running step 8 (analysis tools) in the command line (my go-to if anything goes weird with dispatch to sasquatch):
Step 8 prerequisites are now Step 6. (it is possible to run some metrics after step 3, but this causes missing astrometry metrics).
So, after Step 6 runs, here is what one can do:
* Set up the stack for your run
* Make sure you're clear on the current weekly, butler, collections, etc.
Currently I'm only aware of `/repo/main+sasquatch_dev` and `/repo/dc2+sasquatch_dev` working for metrics dispatch.
First I generally just build the quantum graph. Running like this means I can re-run the graph with `--skip-existing-in` if something goes wrong in the middle.
  * For RC2: `pipetask qgraph -b /repo/main+sasquatch_dev --save-qgraph atools.qgraph -p $DRP_PIPE_DIR/pipelines/HSC/DRP-RC2.yaml#step8 --input HSC/runs/RC2/${weekly}/${ticket_number} --output HSC/runs/RC2/${weekly}/${ticket_number} --qgraph-datastore-records -c parameters:sasquatch_dataset_identifier=HSC/RC2 -c parameters:sasquatch_timestamp_version=reference_package_timestamp`
  * For DC2, you want to swap out `/repo/main+sasquatch_dev` for `/repo/dc2+sasquatch_dev` and `sasquatch_dataset_identifier=HSC/RC2` for `sasquatch_dataset_identifier=DC2/TestMed1`. You'll notice that these parameters are the same between the command-line and BPS yaml files here.
* Next I run the quantum graph! `pipetask run -b /repo/main+sasquatch_dev -g atools.qgraph -j 24` (again switching out the butler for DC2). As this runs it will say how many datasets were transferred, etc. If something goes wrong mid-run, re-run the graph with `--skip-existing-in` and see what happens.
This is equivalent to running step 8, but all the parameters and the sasquatch butler mean metrics get dispatched to Chronograf which you should check after this completes to make sure it was a success.
## Generating resource usage metrics
If you are sure all desired data products are in the campaign collection (make sure all inputs are run collections are present), you can run resource usage metrics.
  1. Set up the stack used for your run.
  2. Build the graph. `build-gather-resource-usage-qg <butler repo> <name>_usage.qgraph <main collection> --output <main collection>`
    So, for HSC-RC2 with w_2023_47, I used `build-gather-resource-usage-qg /repo/main w_2023_47_usage.qgraph HSC/runs/RC2/w_2023_47/DM-41856 --output HSC/runs/RC2/w_2023_47/DM-41856`.
  3. Run the graph. `pipetask run -b <butler repo> -g <name>_usage.qgraph -o <main collection> --register-dataset-types`
    So, for HSC-RC2 with w_2023_47, I used `pipetask run -b /repo/main -g w_2023_47_usage.qgraph -o HSC/runs/RC2/w_2023_45/DM-41856 --register-dataset-types`
## If `finalJob.bash` (`final_job.bash`, etc) fails (and the rest of the workflow is successful):
This essentially means something failed in transferring processed data from the quantum graph back to the butler datastore. We can fix this by manually running the equivalent `butler transfer-datasets` command:
* Set up the stack for your run
* Navigate to the submit directory and find the quantum graph associated with your workflow.
* `butler --long-log --log-level=VERBOSE transfer-from-graph ${qgraphFile} ${butlerConfig} --register-dataset-types --update-output-chain --transfer-dimensions`
  * So for RC2: `butler --long-log --log-level=VERBOSE transfer-from-graph <name_of_qgraph_file>.qgraph /repo/main --register-dataset-types --update-output-chain --transfer-dimensions`
