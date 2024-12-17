#!/usr/bin/env bash

pushd /ccs/proj/lgt130/quda_builds/ChromaBuildScripts/frontier/quda_usqcd_hip_rocm_6_2_4
source /ccs/proj/lgt130/quda_builds/ChromaBuildScripts/frontier/quda_usqcd_hip_rocm_6_2_4/env.sh
popd

export OMP_NUM_THREADS=4

PROG="$INSTALLROOT/$LALIBE/bin/lalibe -geom 1 1 2 4"
export QUDA_RESOURCE_PATH=/lustre/orion/proj-shared/lgt130/production/quda_resource
[[ -d $QUDA_RESOURCE_PATH ]] || mkdir -p $QUDA_RESOURCE_PATH
export QUDA_ENABLE_DSLASH_POLICY="0,1,6,7"



ini=./prop_a12m310_a_3000_gf1.0_w3.0_n30_M51.2_L58_a1.50_mu0.0126_md0.0126_ms0.0693_x22y13z20t31_mg0.1258_qe1.0.ini.xml
out=./prop_a12m310_a_3000_gf1.0_w3.0_n30_M51.2_L58_a1.50_mu0.0126_md0.0126_ms0.0693_x22y13z20t31_mg0.1258_qe1.0.out.xml
stdout=./prop_a12m310_a_3000_gf1.0_w3.0_n30_M51.2_L58_a1.50_mu0.0126_md0.0126_ms0.0693_x22y13z20t31_mg0.1258_qe1.0.stdout

srun -N 1 -n 8 --unbuffered  --cpus-per-task=4 $PROG -i $ini -o $out > $stdout 2>&1

