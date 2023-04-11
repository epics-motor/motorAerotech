# motorAerotech Releases

## __R1-1-1 (2023-04-11)__
R1-1-1 is a release based on the master branch.  

### Changes since R1-1

#### New features
* None

#### Modifications to existing features
* Commit [7d65d96](https://github.com/epics-motor/motorAerotech/commit/7d65d964cb1a232f5e56515d8793ccd38c3c6820): SUPPORT has been removed from the RELEASE file; use RELEASE.local to define it instead.

#### Bug fixes
* Pull request [#10](https://github.com/epics-motor/motorAerotech/pull/10): Send "WAIT MODE NOWAIT" command at initialization to avoid communication timeouts.
* Pull request [#11](https://github.com/epics-motor/motorAerotech/pull/11): Fix from [Ken Lauer](https://github.com/klauer) for doCommand.ab synchronization bug

#### Documentation
* Pull request [#9](https://github.com/epics-motor/motorAerotech/pull/9): Added docs/README_Ensemble.md, which includes the same content as aerotechApp/src/README but is easier to find.

#### Continuous integration
* Added ci-scripts (v3.0.1)
* Configured to use Github Actions for CI

## __R1-1 (2020-05-12)__
R1-1 is a release based on the master branch.  

### Changes since R1-0-1

#### New features
* Commit [03cec30](https://github.com/epics-motor/motorAerotech/commit/03cec3075b927373102bae4042e1ec7c8fbbc039): User displays can now be autoconverted at build time

#### Modifications to existing features
* Commit [aaca941](https://github.com/epics-motor/motorAerotech/commit/aaca9411ed75986ec11afc51cc8e89a7d8da3137): ``CONFIG_SITE`` now includes ``$(SUPPORT)/configure/CONFIG_SITE``, if it exists
* Commit [7f063cc](https://github.com/epics-motor/motorAerotech/commit/7f063cc04a8ded76ce45bf48dbea0dd231e8ca44): ``SUPPORT`` is now defined in ``RELEASE``, which is needed for autoconvert
* Commit [8f1d51a](https://github.com/epics-motor/motorAerotech/commit/8f1d51a8f721f1b19bd025c65ff2132738e6b859): User displays have been autoconverted using the latest converter

#### Bug fixes
* Pull request [#4](https://github.com/epics-motor/motorAerotech/pull/4): Set the motorAxisHomed bit in the poller function in drvEnsembleAsyn.cc
* Commit [9abae64](https://github.com/epics-motor/motorAerotech/commit/9abae6420d0e7df2a7369105f577cc5f783e3a6b): Include ``$(MOTOR)/modules/RELEASE.$(EPICS_HOST_ARCH).local`` instead of ``$(MOTOR)/configure/RELEASE``
* Pull request [#5](https://github.com/epics-motor/motorAerotech/pull/5): Eliminated compiler warnings

## __R1-0-1 (2019-08-08)__
R1-0-1 is a release based on the master branch.  

### Changes since R1-0

#### Modifications to existing features
* Commit [5151930](https://github.com/epics-motor/motorAerotech/commit/515193041306d42fba9fe6c0a3238cb446663152): Improvements to EnsembleTrajectoryScan from [Tim Mooney](https://github.com/timmmooney)
* Commit [8234d38](https://github.com/epics-motor/motorAerotech/commit/8234d387e24408191495551e45713d115d995639): Added build rule to allow *.req files to be installed when building against base 3.14

## __R1-0 (2019-04-18)__
R1-0 is a release based on the master branch.  

### Changes since motor-6-11

motorAerotech is now a standalone module, as well as a submodule of [motor](https://github.com/epics-modules/motor)

#### New features
* motorAerotech can be built outside of the motor directory
* motorAerotech has a dedicated example IOC that can be built outside of motorAerotech

#### Modifications to existing features
* None

#### Bug fixes
* None
