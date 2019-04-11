# Serial
drvAsynSerialPortConfigure("EnsemblePort","/dev/ttyS0",0,0,0)
# Ethernet
#!drvAsynIPPortConfigure("EnsemblePort","xx.xx.xx.xx:8000", 0, 0, 0)

dbLoadTemplate("Ensemble.substitutions")

# Aerotech Ensemble digital servo controller
#     (1) maximum number of controllers in system
EnsembleAsynSetup(1)

# The Ensemble driver does not set end of string (EOS).
asynOctetSetInputEos("EnsemblePort",0,"\n")
asynOctetSetOutputEos("EnsemblePort",0,"\n")

#     (1) Controller number being configured
#     (2) ASYN port name
#     (3) ASYN address (GPIB only)
#     (4) Number of axes this controller supports
#     (5) Time to poll (msec) when an axis is in motion
#     (6) Time to poll (msec) when an axis is idle. 0 for no polling
EnsembleAsynConfig(0, "EnsemblePort", 0, 1, 100, 1000)

# Asyn-based Motor Record support
#   (1) Asyn port
#   (2) Driver name
#   (3) Controller index
#   (4) Max. number of axes
drvAsynMotorConfigure("AeroE1","motorEnsemble",0,1)
