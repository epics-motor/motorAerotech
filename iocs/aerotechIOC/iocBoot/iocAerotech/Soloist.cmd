# Serial
drvAsynSerialPortConfigure("SoloistPort","/dev/ttyS1",0,0,0)
# Ethernet
#!drvAsynIPPortConfigure("SoloistPort","xx.xx.xx.xx:8000", 0, 0, 0)

dbLoadTemplate("Soloist.substitutions")

# SoloistSetup(
#     num cards,
#     poll rate (1/60 sec units))
SoloistSetup(1, 10)

# SoloistConfig(
#     card,
#     asyn port,
#     addr)
SoloistConfig(0, "SoloistPort", 0)
