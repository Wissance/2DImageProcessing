# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLOCK" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FREQUENCY" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLOCK { PARAM_VALUE.CLOCK } {
	# Procedure called to update CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK { PARAM_VALUE.CLOCK } {
	# Procedure called to validate CLOCK
	return true
}

proc update_PARAM_VALUE.FREQUENCY { PARAM_VALUE.FREQUENCY } {
	# Procedure called to update FREQUENCY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FREQUENCY { PARAM_VALUE.FREQUENCY } {
	# Procedure called to validate FREQUENCY
	return true
}


proc update_MODELPARAM_VALUE.CLOCK { MODELPARAM_VALUE.CLOCK PARAM_VALUE.CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLOCK}] ${MODELPARAM_VALUE.CLOCK}
}

proc update_MODELPARAM_VALUE.FREQUENCY { MODELPARAM_VALUE.FREQUENCY PARAM_VALUE.FREQUENCY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FREQUENCY}] ${MODELPARAM_VALUE.FREQUENCY}
}

