# launcher-demo
To  run this demo
ls should show 
launcher.sh 
pt.sh
README.md
src/
test_omp.lsf

## fix environment add PT and PG environment variables 
> ./pt.sh

This will create a ${HOME}/.myenv file and modify your ${HOME}.profile to source 
the new **myenv** file.

At this point you can either source your .profile
> . $HOME/.profile

or

> source $HOME/.profile

or logout and log back in.



to test 
echo $PT
it should show 
/gpfs/panther/local/.....

To run a job we use the launcher script to submit the job.  
The launcher script 
will copy the source code in this example in src/omp_hello.c to the current directory
and compile it using gcc7/7.1.0

will stage the data and executable to 
$PT/data_exe

then submits the test_omp.lsf job using bsub.

### NOTE must use NOHUP!! with launcher
** nohup launcher.sh \& **
or 
** nohup launcher.sh > l1.log **
