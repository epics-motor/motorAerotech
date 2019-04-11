TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

# The following are used for debugging messages.
#!USR_CXXFLAGS += -DDEBUG

#=============================
# Build the IOC application

PROD_IOC = aerotech
# aerotech.dbd will be created and installed
DBD += aerotech.dbd

# aerotech.dbd will be made up from these files:
aerotech_DBD += base.dbd

# Include dbd files from all support applications:
#ifdef ASYN
aerotech_DBD += asyn.dbd
#endif
aerotech_DBD += motorSupport.dbd
aerotech_DBD += devAerotech.dbd

# Add all the support libraries needed by this IOC
aerotech_LIBS += aerotech
aerotech_LIBS += motor
#ifdef ASYN
aerotech_LIBS += asyn
#endif
#ifdef SNCSEQ
aerotech_LIBS += seq pv
#endif

# aerotech_registerRecordDeviceDriver.cpp derives from aerotech.dbd
aerotech_SRCS += aerotech_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
aerotech_SRCS_DEFAULT += aerotechMain.cpp
aerotech_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#aerotech_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
aerotech_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

