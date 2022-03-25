
## Function
test_func <- function(par){
  info <- Sys.info()["nodename"]
  c(s_c=paste(par, "th : Hello from ", info[1], sep=""))
}

## Input
n <- 100
pars <- data.frame(par=1:n)

## Parallel computing using rslurm package
library(rslurm)

sjob <- slurm_apply(test_func,                   # function
                    pars,                        # input
                    jobname='test',              # job name
                    nodes=4,                     # the (max) number of nodes you want to use
                    cpus_per_node=40,            # the (max) number of cpus you want to use (number of thread)
                    add_objects=NULL,            # additional data
                    pkgs=NULL,                   # packages you want to use
                    slurm_options=list("sockets-per-node"=2,"cores-per-socket"=9,"threads-per-core"=2,
                                       "mail-type"="END","mail-user"="acarlos93@snu.ac.kr"))

# If you want to link 'sjob' to the slurm job 'test',
# add "submit=FALSE" to the argument of slurm_apply


## Print current job status
print_job_status(sjob)

## Results
res <- get_slurm_out(sjob, outtype = "table")
res

res_raw <- get_slurm_out(sjob, outtype = "raw", wait = FALSE)
res_raw

## Clean up files
cleanup_files(sjob)

## Cancel the job
cancel_slurm(sjob)

