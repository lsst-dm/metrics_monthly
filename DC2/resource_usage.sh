#!/bin/env bash
build-gather-resource-usage-qg /repo/dc2 dc2_w_2023_21_resource_usage.qgraph 2.2i/runs/test-med-1/w_2023_21/DM-39419

pipetask --long-log --log-level=INFO run -b /repo/dc2 --output 2\
.2i/runs/test-med-1/w_2023_21/DM-39419 -g dc2_w_2023_21_resource_usage.qgraph --register-dataset-types
