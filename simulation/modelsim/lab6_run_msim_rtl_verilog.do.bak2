transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/ram128x9.v}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/top_module.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/add_sub.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/lab6.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/dec3to8.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/full_adder.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/mux16to1.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/counter.sv}
vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/bcd7seg.sv}

vlog -sv -work work +incdir+D:/HK252/Digital_systems/Lab/lab6 {D:/HK252/Digital_systems/Lab/lab6/top_module_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  top_module_tb

add wave *
view structure
view signals
run -all
