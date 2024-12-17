module purge
module load DefApps-spi
module load cpe/24.07
module load PrgEnv-amd
module load amd/6.2.4
module load rocm/6.2.4
module load craype-accel-amd-gfx90a
module load cray-mpich/8.1.30
module load cmake
module load gcc-mixed/12.2.0
module load libfabric/1.15.2.0
module load ninja/1.11.1
module load xpmem/2.8.4-1.0_7.3__ga37cbd9.shasta
module list

export MPICH_ROOT=/opt/cray/pe/mpich/8.1.30
export GTL_ROOT=/opt/cray/pe/mpich/8.1.30/gtl/lib
export MPICH_DIR=${MPICH_ROOT}/ofi/amd/6.0
export LIBDEVICE="-libdevice-path ${ROCM_PATH}/llvm/lib -libdevice-name libomptarget-new-amdgpu-gfx90a.bc"
export LD_LIBRARY_PATH=/sw/frontier/spack-envs/base/opt/linux-sles15-x86_64/gcc-7.5.0/zstd-1.5.0-fffxf5wbot6b25clhjf66d53xmdbqeo3/lib:$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

QUDA=quda_DWF
QUDA_SRC=quda
QMP=qmp
QDP=qdpxx
CHROMA=chroma
LALIBE=lalibe

CC=hipcc
CXX=hipcc

## These must be set before running

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export TARGET_GPU=gfx90a

MPI_CFLAGS="${CRAY_XPMEM_INCLUDE_OPTS} -I${MPICH_DIR}/include -I${ROCM_PATH}/include/hipblas -I${ROCM_PATH}/include/hipfft"
MPI_LDFLAGS="-L/opt/cray/libfabric/1.15.2.0/lib64  -Wl,--rpath=/opt/cray/libfabric/1.15.2.0/lib64 ${CRAY_XPMEM_POST_LINK_OPTS} -lxpmem  -Wl,-rpath=${MPICH_DIR}/lib -L${MPICH_DIR}/lib -lmpi -Wl,-rpath=${GTL_ROOT} -L${GTL_ROOT} -lmpi_gtl_hsa -L${ROCM_PATH}/llvm/lib -Wl,-rpath=${ROCM_PATH}/llvm/lib"

export MPICH_GPU_SUPPORT_ENABLED=1
export QUDA_ENABLE_P2P=0
export QUDA_ENABLE_GDR=1  
export QUDA_BUILD_TYPE="RELEASE"

export PK_BUILD_TYPE="Release"

export PATH=${ROCM_PATH}/bin:${ROCM_PATH}/llvm/bin:${PATH}
    
export LD_LIBRARY_PATH=${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:/${INSTALLROOT}/${QUDA}/lib:${ROCM_PATH}/lib:${ROCM_PATH}/llvm/lib:${MPICH_DIR}/lib:${GTL_ROOT}:/opt/cray/libfabric/1.15.2.0/lib64:${LD_LIBRARY_PATH}

export LIBRARY_PATH=${ROCM_PATH}/include:${LIBRARY_PATH}
