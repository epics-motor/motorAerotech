## CONFIGURATION NOTES

Database definition (*.dbd) requirements.

```
<App>DBD += devAerotech.dbd
```

Startup command file (st.cmd) requirements.

```
("#"  is used to denote st.cmd comment lines.)
("#!" is used to denote st.cmd commented out command lines.)
```

Configure an asyn communications port driver for the Ensemble. This can be either RS-232 or ethernet. For example,

```
#!EnsemblePort = "Serial"
#!drvAsynSerialPortConfigure(EnsemblePort,"/tyGS0/Mod0/1",0,0,0)

#!EnsemblePort = "tcp1"
#!drvAsynIPPortConfigure(EnsemblePort,"xx.xx.xx.xx:8000", 0, 0, 0)
```

See asyn documentation for details.

```
# Aerotech Ensemble digital servo controller
#     (1) maximum number of controllers in system
#!EnsembleAsynSetup(1)

# The Ensemble driver does not set end of string (EOS).
#!asynOctetSetInputEos(EnsemblePort,0,"\n")
#!asynOctetSetOutputEos(EnsemblePort,0,"\n")

#     (1) Controller number being configured
#     (2) ASYN port name
#     (3) ASYN address (GPIB only)
#     (4) Number of axes this controller supports
#     (5) Time to poll (msec) when an axis is in motion
#     (6) Time to poll (msec) when an axis is idle. 0 for no polling
#!EnsembleAsynConfig(0, EnsemblePort, 0, 1, 100, 1000)

# Asyn-based Motor Record support
#   (1) Asyn port
#   (2) Driver name
#   (3) Controller index
#   (4) Max. number of axes
#!drvAsynMotorConfigure("AeroE1","motorEnsemble",0,1)
```

## DESIGN NOTES

* The EPICS driver neither reads nor writes the Ensemble's soft limits.  It is
recommended that the Ensemble soft limits be disabled and the user rely on the
EPICS motor record soft limits.

* Since the Ensemble network connection requires period communication from the
host to prevent the Ensemble from closing the network socket, the Ensemble
support based on the old device driver architecture will be removed after R5-6.
The asyn motor architecture supports continuous, periodic updates; the old
architecture does not.

* This driver assumes that the EOT limit switches have been configured
correctly.  If the PosScaleFactor parameter is positive, then a positive move
is a move in the direction of the CW EOT limit switch and a negative move is a
move in the direction of the CCW EOT limit switch.  If the PosScaleFactor
parameter is negative, then a positive move is a move in the direction of the
CCW EOT limit switch and a negative move is a move in the direction of the CW
EOT limit switch

* If the stage has no limit switches, then configure the EndOfTravelLimitSetup
parameter to active low (assuming the limit switch inputs are unconnected and
always high).


## ENSEMBLE CONFIGURATION NOTES

The following is for Ensemble firmware version 4.02.004 and above.

```
- In the System->Communication->ASCII->CommandSetup Parameter,
check the following items (everything else is unchecked);
    * RS232 Port 0, OR, Ethernet Socket 2
    * Always Send EOS
- For ethernet, in the System->Communication->Ethernet Sockets section;
	- in the ->Socket2Setup Parameter, check the "TCP server" setting.
	- Enter the IP address in the ->Socket2RemoteIPAddress Parameter
	- Leave the ->Socket2Port Parameter at the default "8000" or set it to
	  match the drvAsynIPPortConfigure() st.cmd call.
	- Set the ->Socket2Timeout Parameter greater than idle polling paramter of
	  the EnsembleAsynConfig() call.
(This will prevent the Ensemble from closing the socket.  In addition, the time
between the call to drvAsynIPPortConfigure() and the call to
EnsembleAsynConfig() in the st.cmd file must be less than the ->Socket2Timeout
Parameter.  If this is not done a socket timeout will occur during IOC
initialization and prevent EPICS from making a communication connection.)
- In order to execute a home search from EPICS, configure the following.
        - Set the System > TaskExecutionSetup parameter so that the Auxiliary task is enabled
        - Copy the HomeAsync.ab from
          C:\Program Files (x86)\Aerotech\Ensemble\Samples\AeroBasic
          to convenient local directory, such as
          C:\Users\Public\Documents\Aerotech\Ensemble\User Files\AeroBasicPrgms
        - From Ensemble Motion Composer, select the Auxililary task, then build and load the HomeAsync program.
        - Finally, from Ensemble Configuration Manager, drag and drop the HomeAsync.bcx file to the Ensemble congtroller's file system.
```

## DRIVER LIMITATIONS

The driver reads the controllers configuration information only at boot-up
(iocInit). If any of the following Ensemble parameters are changed, EPICS
must be rebooted.

- PositionFeedbackType
- CountsPerUnit
- HomeOffset
- HomeSetup
- EndOfTravelLimitSetup
- ReverseMotionDirection


## Files in aerotechApp/src

What all the files in this directory are.

### EPICS stuff

```
AerotechRegister.cc
AerotechRegister.h
devAerotech.dbd
```

### non-asyn device/driver

```
devSoloist.cc
drvSoloist.cc
drvSoloist.h
```

### asyn model 2 driver
```
drvEnsembleAsyn.cc
drvEnsembleAsyn.h
ParameterId.h
```

### trajectory support
```
EnsembleTrajectoryScan.h
EnsembleTrajectoryScan.st
```

## Ensemble Trajectory Scan

This software talks to the asyn port specified as an argument to the
EnsembleAsynConfig() command, and it needs an Ensemble controller that has
been prepared with the AeroBasic program "doCommand.ab", which is included
in this directory.  You must copy doCommand.ab to into Motion Composer's
user file directory, load it into Motion Composer, and compile it to produce
the file doCommand.bcx.  This file must be copied to the controller, so it
can be executed immediately when EnsembleTrajectoryScan.st sends the command
'PROGRAM 5 "doCommand.bcx"'.  The controller also must be configured to
increase the number of global integers and doubles.  For N trajectory
points, the number of global doubles must be at least (N+3)*3 (for one
motor), and the number of global integers must be at least N+50.  Also, the
controller must use the same units as the motor record that talks to it.

This software is not ready for multiple-motor trajectories.

doCommand is needed because the Ensemble commands that execute a trajectory
are not available via the ASCII interface through which drvEnsembleAsyn
and EnsembleTrajectoryScan talk to the controller.

To use this software, you must load a motor record configured to control an
Ensemble motor, for example by executing the following commands:

```
dbLoadTemplate("AeroAsyn.substitutions")
drvAsynIPPortConfigure("tcp1","164.54.51.77:8000", 0, 0, 0)
EnsembleAsynSetup(1)
EnsembleAsynConfig(0, "tcp1", 0, 1, 50, 1000)
drvAsynMotorConfigure("AeroE1","motorEnsemble",0,1)
```

where the file AeroAsyn.substitutions has the following content:

```
file "$(MOTOR)/db/asyn_motor.db"
{
pattern
{P,     N,  M,        DTYP,         PORT,   ADDR,  DESC,          EGU,  DIR,  VELO,  VBAS,  ACCL,  BDST,  BVEL,  BACC,  MRES,   PREC,  DHLM,  DLLM,           INIT}
{xxxL:,  17,  "m$(N)",  "asynMotor",  AeroE1,    0,  "motor $(N)",  mm,   Pos,  .1,     0,    .2,    0,     1,     .2,    1.25E-5,   7,     0,      0,  "SCURVE 100"}
}
```

On top of this support, you must load and execute the trajectoryScan database, and execute the SNL program:

```
dbLoadRecords("$(MOTOR)/motorApp/Db/trajectoryScan.db","P=xxxL:,R=traj1:,NAXES=1,NELM=1000,NPULSE=1000")
...
iocInit
...
seq &EnsembleTrajectoryScan, "P=xxxL:,R=traj1:,M1=m17,M2=m2,M3=m3,M4=m4,M5=m5,M6=m6,M7=m7,M8=m8,PORT=tcp1"
```

You'll probably want autosave to manage the trajectory PVs.  Add the following line to auto_settings.req:

```
file trajectoryScan_settings.req P=$(P),R=traj1:
```
