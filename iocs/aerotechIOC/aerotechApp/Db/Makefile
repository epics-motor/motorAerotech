TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this
#DB += xxx.db

ifdef MOTOR_AEROTECH
### this module was built outside motor
DB_INSTALLS += $(MOTOR_AEROTECH)/db/EnsemblePSOFly.db
DB_INSTALLS += $(MOTOR_AEROTECH)/db/EnsemblePSOFly_settings.req
DB_INSTALLS += $(MOTOR_AEROTECH)/db/EnsemblePVerr.db
else
### this module was built inside motor/modules
DB_INSTALLS += $(MOTOR)/db/EnsemblePSOFly.db
DB_INSTALLS += $(MOTOR)/db/EnsemblePSOFly_settings.req
DB_INSTALLS += $(MOTOR)/db/EnsemblePVerr.db
endif

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

