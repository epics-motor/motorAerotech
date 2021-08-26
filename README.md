# motorAerotech
EPICS motor drivers for the following [Aerotech](https://www.aerotech.com/) controllers: A3200, Ensemble and Soloist

EPICS motor drivers for [Automation1](https://www.aerotech.com/product/software/automation1-software-based-machine-controller/) controllers can be found in the [motorAutomation1](https://github.com/epics-motor/motorAutomation1) module.

[![Build Status](https://travis-ci.org/epics-motor/motorAerotech.png)](https://travis-ci.org/epics-motor/motorAerotech)

motorAerotech is a submodule of [motor](https://github.com/epics-modules/motor).  When motorAerotech is built in the ``motor/modules`` directory, no manual configuration is needed.

motorAerotech can also be built outside of motor by copying it's ``EXAMPLE_RELEASE.local`` file to ``RELEASE.local`` and defining the paths to ``MOTOR`` and itself.

motorAerotech contains an example IOC that is built if ``CONFIG_SITE.local`` sets ``BUILD_IOCS = YES``.  The example IOC can be built outside of driver module.
