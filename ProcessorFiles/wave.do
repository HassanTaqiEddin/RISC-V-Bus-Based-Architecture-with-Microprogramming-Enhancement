onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Clock And Reset}
add wave -noupdate /datapath_tb/clock
add wave -noupdate /datapath_tb/reset
add wave -noupdate -divider {Special Registers}
add wave -noupdate /datapath_tb/dp/_IR/R
add wave -noupdate /datapath_tb/dp/_A/R
add wave -noupdate /datapath_tb/dp/_B/R
add wave -noupdate /datapath_tb/dp/_MA/R
add wave -noupdate -divider Bus
add wave -noupdate /datapath_tb/dp/sharedBus
add wave -noupdate /datapath_tb/dp/Immout
add wave -noupdate /datapath_tb/dp/IR_out
add wave -noupdate /datapath_tb/dp/MA_out
add wave -noupdate /datapath_tb/dp/RF_addr
add wave -noupdate -divider {Micro Operation Program Counter}
add wave -noupdate /datapath_tb/dp/cu/MPC
add wave -noupdate /datapath_tb/dp/cu/OP_GROUPS
add wave -noupdate -divider {Registers In Register File}
add wave -noupdate /datapath_tb/dp/RF/r
add wave -noupdate -divider {Memory Locations}
add wave -noupdate /datapath_tb/dp/mem/MEM
add wave -noupdate -divider <NULL>
add wave -noupdate /datapath_tb/dp/A_out
add wave -noupdate /datapath_tb/dp/B_out
add wave -noupdate /datapath_tb/dp/aluOut
add wave -noupdate /datapath_tb/dp/Immout
add wave -noupdate /datapath_tb/dp/memIO
add wave -noupdate /datapath_tb/dp/regFileIO
add wave -noupdate /datapath_tb/dp/rs
add wave -noupdate /datapath_tb/dp/rt
add wave -noupdate /datapath_tb/dp/rd
add wave -noupdate /datapath_tb/dp/Opcode
add wave -noupdate /datapath_tb/clock
add wave -noupdate /datapath_tb/reset
add wave -noupdate /datapath_tb/dp/rt
add wave -noupdate /datapath_tb/dp/rs
add wave -noupdate /datapath_tb/dp/rd
add wave -noupdate /datapath_tb/dp/Opcode
add wave -noupdate /datapath_tb/dp/aluOut
add wave -noupdate /datapath_tb/dp/cu/nextState
add wave -noupdate /datapath_tb/dp/clock
add wave -noupdate /datapath_tb/dp/reset
add wave -noupdate /datapath_tb/dp/ldIR
add wave -noupdate /datapath_tb/dp/ldA
add wave -noupdate /datapath_tb/dp/ldB
add wave -noupdate /datapath_tb/dp/ldMA
add wave -noupdate /datapath_tb/dp/enReg
add wave -noupdate /datapath_tb/dp/enMem
add wave -noupdate /datapath_tb/dp/enALU
add wave -noupdate /datapath_tb/dp/enImm
add wave -noupdate /datapath_tb/dp/RegWrt
add wave -noupdate /datapath_tb/dp/MemWrt
add wave -noupdate /datapath_tb/dp/RegSel
add wave -noupdate /datapath_tb/dp/ALUOp
add wave -noupdate /datapath_tb/dp/ExSel
add wave -noupdate /datapath_tb/dp/Opcode
add wave -noupdate /datapath_tb/dp/zero
add wave -noupdate /datapath_tb/dp/busy
add wave -noupdate /datapath_tb/dp/funct3
add wave -noupdate /datapath_tb/dp/funct7
add wave -noupdate /datapath_tb/dp/sharedBus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {73 ns}
