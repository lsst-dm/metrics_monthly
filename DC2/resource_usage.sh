#!/bin/env bash
build-gather-resource-usage-qg /repo/dc2 dc2_w_2023_17_resource_usage.qgraph 2.2i/runs/test-med-1/w_2023_17/DM-39092

pipetask --long-log --log-level=INFO run -b /repo/dc2 --output 2\
.2i/runs/test-med-1/w_2023_17/DM-39092 -g dc2_w_2023_17_resource_usage.qgraph --register-dataset-types
