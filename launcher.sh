#!/bin/bash --login
# This is the README file is an executable script.
# To run type: ./README
#
# Example OBjECTIVE: to demostrate omp_hello.c example
# on Panther with GNU compiler.
# omp_hello.c code is taken from
# https://computing.llnl.gov/tutorials/openMP/exercise.html
# cp the omp_hello.c source code

#cp $GE_DIR/src/omp_hello.c .
cp src/omp_hello.c .

# This code is an OpenMP example that runs one 16-thread
# OpenMP instance with one node.

# To run this code load the necessary modules.
# and specify the total number of OpenMP threads.
# This information is located under hello_omp_gnu.slurm
# You can edit the LSF as: emacs hello_omp_gnu.slurm &

# LSF directives
# 
# Here we specify to LSF that we want 1 node (--nodes=1)
# Then, we modify the partition to --partition==workq
# To run this code correctly, we comment out: --export=NONE
# If this is not commented out, the code does not run.
# To compile the code with GNU,
# we need to load the gcc module as shown below: 

module load gcc7/7.1.0

# To compile the omp_hello.c code with GNU
gcc -O2 -fopenmp omp_hello.c -o hello_omp_gnu

# Create a temp-storage directory and copy data and/or executables
# Note! copying executables is not needed if modules are used.

if [ ! -d $PT/data_exe ]; then
    mkdir $PT/data_exe
fi

cp hello_omp_gnu $PT/data_exe/.

# sanity check that files are there
ls -al $PT/data_exe

# To submit the job to Panther and extract jobid
id=$(bsub <  test_omp.lsf) 
jobid=`echo $id | awk '{print $2}' | sed 's/<//g' | sed 's/>//g'`
# 
#  Need $jobid to help organize results.
echo " job submission id is $jobid "
echo " my lsb_remote jobid is $LSB_REMOTEJID "

#echo "The LSF command returns what the jobid is for this job."
echo "To check the status of your job, use the slurm command:"
echo "bjobs -u $USER"
echo " "
echo "Your job will be run in ${PT}/run_helloOmpC_gnu/${jobid}."
echo " "
echo "Your results will be saved in ${HCCDS}/helloOmpC_gnu_results/${jobid}"
echo "and the scratch directory will then be deleted."
echo " "
echo "To check the results change to your jobid directory, type:"
echo "cd ${HCCDS}/helloOmpC_gnu_results/${jobid}"
echo " " 
echo "To view the results, use the cat command and type:"
echo "cat helloOmpC_gnu.log"
echo " "
echo " "
#echo " "


while [[ ! -f $PT/cpt$jobid ]]; do
  sleep 2
done

RESULTS=$HCCDS/helloworld_gnu_results
###############################################
# Creates a unique directory in your GROUP directory for the results of this job
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS

# move results from scratch back to CDS
mv  ${PT}/run_helloOmpC_gnu/$jobid  $RESULTS

## CLEAN UP stuff!
#rm -rf ${PT}/run_helloOmpC_gnu/$jobid
rm ${PT}/cpt$jobid


