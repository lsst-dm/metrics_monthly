# DRP Monthly Metrics Reprocessing: An introduction
These collected submit yamls are intended for use by Rubin campaign management pilots at USDF at SLAC. In this folder, one will find a collection of tests, and then submit yamls organized by campaign. These currently include the two campaigns being used for monthly evaluation of DRP metrics [see reference page for details and output from these processing efforts]( https://confluence.lsstcorp.org/display/DM/Monitoring+DRP+Pipeline+Performance) -- these are **[HSC-RC2](https://dmtn-088.lsst.io)** and **DC2 test-med-1**. These runs are both broken up into processing steps, which are detailed in [`drp_pipe`](https://github.com/lsst/drp_pipe/tree/main) and necesitated by output data products and smallest units of parallelization.
## Submitting reprocessing yaml files to the USDF
This repository contains yaml files which can be submitted to a high-throughput compute workflow management system (WMS) on the USDF for medium-sized processing runs. 

In each campaign folder one will find yamls to be submitted with [BPS](https://pipelines.lsst.io/modules/lsst.ctrl.bps/index.html) to either [PanDA](https://pipelines.lsst.io/modules/lsst.ctrl.bps.panda/index.html) or [HTCondor](https://pipelines.lsst.io/modules/lsst.ctrl.bps.htcondor/index.html). 

In these folders one will also find two setup files. These files set up the lsst stack ([the process of which can be done in many ways](https://developer.lsst.io/usdf/stack.html)) and also set a number of relevant parameters for the WMS. In either case, the basic usage for these files is to `source <setup_file>.sh` and then run `bps submit <yaml_file>.yaml` (I prefer the incantation `bps submit <yaml_file>.yaml &> logs/<yaml_file>.log`). 

In the case of HTCondor workflows, one must also allocate compute nodes, best done using [`allocateNodes.py`](https://developer.lsst.io/usdf/batch.html) (the incantation I have been using for these workflows is `allocateNodes.py -v --dynamic -n 20 -c 32 -m 4-00:00:00 -q roma,milano -g 3600 s3df`).

When the user runs `bps submit`, a submit directory is created in the active directory with many useful outputs from the run. To track what occurred during the run, use `bps report` and the `--id` option (PanDA workflows will use the request ID here; HTCondor workflows will use the slurm id or the directory marked as "submitting from" by the output of the `submit`).

For post-run information on quanta, errors and their outcomes, as of w_2023_46, one may also use `pipetask report` to investigate (type `pipetask report -h` in the terminal with the stack set up for details).

Finally, these are not the only methods for submitting metrics monthly processing to the USDF. the prototype [cm_prod](https://github.com/lsst-dm/cm_prod) and [cm_tools](https://github.com/lsst-dm/cm_tools), and the future [cm_service]() packages are designed for further grouping, automation, and management of processing runs including but not limited to these. For more information on using the `cm_tools` prototype, see [CM Tools Usage Notes](https://confluence.lsstcorp.org/display/DM/CM+Tools+usage+notes).
