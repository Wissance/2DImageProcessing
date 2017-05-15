# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RESET_IMAGE_CAPTURE_COMMAND" -parent ${Page_0}
  ipgui::add_param $IPINST -name "START_IMAGE_CAPTURE_COMMAND" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STOP_IMAGE_CAPTURE_COMMAND" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to update RESET_IMAGE_CAPTURE_COMMAND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to validate RESET_IMAGE_CAPTURE_COMMAND
	return true
}

proc update_PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to update START_IMAGE_CAPTURE_COMMAND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to validate START_IMAGE_CAPTURE_COMMAND
	return true
}

proc update_PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to update STOP_IMAGE_CAPTURE_COMMAND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND { PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to validate STOP_IMAGE_CAPTURE_COMMAND
	return true
}


proc update_MODELPARAM_VALUE.START_IMAGE_CAPTURE_COMMAND { MODELPARAM_VALUE.START_IMAGE_CAPTURE_COMMAND PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.START_IMAGE_CAPTURE_COMMAND}] ${MODELPARAM_VALUE.START_IMAGE_CAPTURE_COMMAND}
}

proc update_MODELPARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND { MODELPARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND}] ${MODELPARAM_VALUE.STOP_IMAGE_CAPTURE_COMMAND}
}

proc update_MODELPARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND { MODELPARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND}] ${MODELPARAM_VALUE.RESET_IMAGE_CAPTURE_COMMAND}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

