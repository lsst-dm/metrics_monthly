mkdir json
cd json
gen3_to_job.py /repo/main 'HSC/runs/RC2/w_WEEKLY/DM-TICKETNUM' --dataset_name 'HSC_RC2'
if [ IS_GEN2TO3 == 1 ]; then
    sed -i "s/Gen3/Gen2to3/g" *.json
fi
