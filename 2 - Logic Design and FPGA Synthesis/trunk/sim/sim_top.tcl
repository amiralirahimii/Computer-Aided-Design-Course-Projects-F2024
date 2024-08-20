	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"MaxnetTB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/absToTwosComp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/And.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/bitMultiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer16x4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/dataPath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/decoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/fullAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Maxnet.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/multiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux2x1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux4x1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Not.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Or.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/processingUnit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/registerBlock.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/S1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/S2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Xor.v

	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	