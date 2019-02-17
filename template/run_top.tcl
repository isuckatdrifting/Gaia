\rm -rf INCA_libs
irun -64bit +sv +define+FFD=0.1+RECREM+NTC \
+notimingcheck \
+access+rw \
+define+DUMP_FSDB \
+define+DFF=0.1 \
+config=$1 \
+seq_num=$2 \
-timescale 1ns/1ps \
-top top_tb \
-vlogext .gv \
-l nc.log \
-f ${filelist}.f \
-uvm -uvmhome CDNS-1.2 \
-input shm.tcl