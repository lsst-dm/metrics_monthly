#!/usr/bin/env sh

$ANALYSIS_DRP_DIR/bin/build-gather-resource-usage-qg /sdf/group/rubin/repo/main $HOME/w_2023_11_usage HSC/runs/RC2/w_2023_11/DM-38360
pipetask run -b /sdf/group/rubin/repo/main -g $HOME/w_2023_11_usage -o u/eiger/w_2023_11_usage --register-dataset-types &> log &