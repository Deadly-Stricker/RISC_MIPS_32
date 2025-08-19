#! /c/Source/iverilog-install/bin/vvp
:ivl_version "12.0 (devel)" "(s20150603-1539-g2693dd32b)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "C:\iverilog\lib\ivl\system.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_sys.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_textio.vpi";
:vpi_module "C:\iverilog\lib\ivl\v2005_math.vpi";
:vpi_module "C:\iverilog\lib\ivl\va_math.vpi";
S_00000214b97c6fb0 .scope module, "MEM_stage" "MEM_stage" 2 1;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 6 "opcode";
    .port_info 2 /INPUT 5 "Rt";
    .port_info 3 /INPUT 32 "Rt_value";
    .port_info 4 /INPUT 32 "effictiveaddr";
    .port_info 5 /OUTPUT 32 "op_mem";
    .port_info 6 /OUTPUT 1 "write_reg";
    .port_info 7 /OUTPUT 5 "Rt_address";
o00000214b97cd258 .functor BUFZ 5, C4<zzzzz>; HiZ drive
v00000214b97c2b60_0 .net "Rt", 4 0, o00000214b97cd258;  0 drivers
v00000214b97c2c00_0 .var "Rt_address", 4 0;
o00000214b97cd2b8 .functor BUFZ 32, C4<zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>; HiZ drive
v00000214b97c2ca0_0 .net "Rt_value", 31 0, o00000214b97cd2b8;  0 drivers
v00000214b97c2d40_0 .var "addrRead", 31 0;
v00000214b97c2de0_0 .var "addrWrite", 31 0;
o00000214b97cd048 .functor BUFZ 1, C4<z>; HiZ drive
v00000214b97c2e80_0 .net "clk", 0 0, o00000214b97cd048;  0 drivers
o00000214b97cd2e8 .functor BUFZ 32, C4<zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>; HiZ drive
v00000214b97c2f20_0 .net "effictiveaddr", 31 0, o00000214b97cd2e8;  0 drivers
v00000214b97c3ab0_0 .var "op_mem", 31 0;
o00000214b97cd348 .functor BUFZ 6, C4<zzzzzz>; HiZ drive
v00000214b97c3f10_0 .net "opcode", 5 0, o00000214b97cd348;  0 drivers
v00000214b97c3790_0 .net "outp_of_mem", 31 0, v00000214b97c72d0_0;  1 drivers
v00000214b97c3510_0 .var "read", 0 0;
v00000214b97c35b0_0 .var "write", 0 0;
v00000214b97c3650_0 .var "write_reg", 0 0;
v00000214b97c31f0_0 .var "write_stuff", 31 0;
E_00000214b97b6210/0 .event anyedge, v00000214b97c3f10_0, v00000214b97c2f20_0, v00000214b97c72d0_0, v00000214b97c2b60_0;
E_00000214b97b6210/1 .event anyedge, v00000214b97c2ca0_0;
E_00000214b97b6210 .event/or E_00000214b97b6210/0, E_00000214b97b6210/1;
S_00000214b97c7140 .scope module, "RAMmem" "MemoryD" 2 15, 3 1 0, S_00000214b97c6fb0;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "addrss1";
    .port_info 1 /INPUT 32 "addrssw";
    .port_info 2 /INPUT 1 "clk";
    .port_info 3 /INPUT 1 "write";
    .port_info 4 /INPUT 1 "read";
    .port_info 5 /INPUT 32 "write_material";
    .port_info 6 /OUTPUT 32 "Outp1";
v00000214b97936f0 .array "Memory_File", 0 31, 31 0;
v00000214b97c72d0_0 .var "Outp1", 31 0;
v00000214b97930e0_0 .net "addrss1", 31 0, v00000214b97c2d40_0;  1 drivers
v00000214b97c7370_0 .net "addrssw", 31 0, v00000214b97c2de0_0;  1 drivers
v00000214b97c28e0_0 .net "clk", 0 0, o00000214b97cd048;  alias, 0 drivers
v00000214b97c2980_0 .net "read", 0 0, v00000214b97c3510_0;  1 drivers
v00000214b97c2a20_0 .net "write", 0 0, v00000214b97c35b0_0;  1 drivers
v00000214b97c2ac0_0 .net "write_material", 31 0, v00000214b97c31f0_0;  1 drivers
E_00000214b97b6450 .event posedge, v00000214b97c28e0_0;
    .scope S_00000214b97c7140;
T_0 ;
    %vpi_call 3 13 "$readmemh", "MEM/content_mem.mem", v00000214b97936f0 {0 0 0};
    %end;
    .thread T_0;
    .scope S_00000214b97c7140;
T_1 ;
    %wait E_00000214b97b6450;
    %load/vec4 v00000214b97c2a20_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_1.0, 8;
    %load/vec4 v00000214b97c2ac0_0;
    %ix/getv 4, v00000214b97c7370_0;
    %store/vec4a v00000214b97936f0, 4, 0;
T_1.0 ;
    %load/vec4 v00000214b97c2980_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_1.2, 8;
    %ix/getv 4, v00000214b97930e0_0;
    %load/vec4a v00000214b97936f0, 4;
    %store/vec4 v00000214b97c72d0_0, 0, 32;
T_1.2 ;
    %jmp T_1;
    .thread T_1;
    .scope S_00000214b97c6fb0;
T_2 ;
    %wait E_00000214b97b6210;
    %load/vec4 v00000214b97c3f10_0;
    %dup/vec4;
    %pushi/vec4 35, 0, 6;
    %cmp/u;
    %jmp/1 T_2.0, 6;
    %dup/vec4;
    %pushi/vec4 43, 0, 6;
    %cmp/u;
    %jmp/1 T_2.1, 6;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v00000214b97c35b0_0, 0;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v00000214b97c3650_0, 0;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v00000214b97c3510_0, 0;
    %jmp T_2.3;
T_2.0 ;
    %pushi/vec4 1, 0, 1;
    %assign/vec4 v00000214b97c3650_0, 0;
    %load/vec4 v00000214b97c2f20_0;
    %assign/vec4 v00000214b97c2d40_0, 0;
    %pushi/vec4 1, 0, 1;
    %assign/vec4 v00000214b97c3510_0, 0;
    %load/vec4 v00000214b97c3790_0;
    %assign/vec4 v00000214b97c3ab0_0, 0;
    %load/vec4 v00000214b97c2b60_0;
    %assign/vec4 v00000214b97c2c00_0, 0;
    %jmp T_2.3;
T_2.1 ;
    %pushi/vec4 1, 0, 1;
    %assign/vec4 v00000214b97c35b0_0, 0;
    %load/vec4 v00000214b97c2f20_0;
    %assign/vec4 v00000214b97c2de0_0, 0;
    %load/vec4 v00000214b97c2ca0_0;
    %assign/vec4 v00000214b97c31f0_0, 0;
    %jmp T_2.3;
T_2.3 ;
    %pop/vec4 1;
    %jmp T_2;
    .thread T_2, $push;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    ".\MEM\MEM_stage.v";
    ".\MEM\datamemory.v";
