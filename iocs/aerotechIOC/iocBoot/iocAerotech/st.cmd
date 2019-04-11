#!../../bin/linux-x86_64/aerotech

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/aerotech.dbd"
aerotech_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

## motorUtil (allstop & alldone)
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=aerotech:")

## 
< Ensemble.cmd
< Soloist.cmd

iocInit

## motorUtil (allstop & alldone)
motorUtilInit("aerotech:")

# Boot complete
