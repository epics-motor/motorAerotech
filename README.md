# motorAerotech
EPICS motor drivers for the following [Aerotech](https://www.aerotech.com/) controllers: A3200, Ensemble and Soloist

motorAerotech is a submodule of [motor](https://github.com/epics-modules/motor).  When motorAerotech is built in the ``motor/modules`` directory, no manual configuration is needed.

motorAerotech can also be built outside of motor by copying it's ``EXAMPLE_RELEASE.local`` file to ``RELEASE.local`` and defining the paths to ``MOTOR`` and itself.

motorAerotech contains an example IOC that is built if ``CONFIG_SITE.local`` sets ``BUILD_IOCS = YES``.  The example IOC can be built outside of driver module.
