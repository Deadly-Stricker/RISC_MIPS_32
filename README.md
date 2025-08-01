# 🧠 Pipelined MIPS32 Processor (5-Stage) - Verilog

This project implements a 5-stage **pipelined MIPS32 processor** using Verilog HDL. The design simulates a basic RISC processor capable of executing a subset of MIPS instructions with full pipelining, hazard detection, and forwarding.

---

## 📌 Project Overview

- **Architecture**: 5-stage pipeline (IF → ID → EX → MEM → WB)
- **Instruction Format**: MIPS32 (R, I, and basic J-type)
- **Data Path Width**: 32 bits
- **Register File**: 32 general-purpose registers
- **Pipeline Features**:
  - Pipeline registers between all stages
  - Hazard detection unit (load-use stall)
  - Forwarding unit (data hazard resolution)
  - ALU and control logic
  - Instruction & data memory modules

---

## 🏗️ Pipeline Stages

| Stage | Description |
|-------|-------------|
| **IF**  | Fetch instruction from memory and increment PC |
| **ID**  | Decode instruction, read registers, and generate control signals |
| **EX**  | Perform ALU operations and branch address calculations |
| **MEM** | Access memory for load/store instructions |
| **WB**  | Write results back to the register file |

---

## ✅ Supported Instructions

### R-Type
- `add`, `sub`, `and`, `or`, `slt`

### I-Type
- `lw`, `sw`, `addi`, `beq`

> (Jumps can be added later: `j`, `jal`, `jr`)

---

## 📦 Folder Structure

## 🔧 Module Descriptions

This section describes each Verilog module used in the 5-stage pipelined MIPS processor design.

---

### 🟩 1. Instruction Fetch (IF) Stage

#### 📌 `pc.v`
- Holds the current Program Counter (PC).
- Updates every cycle with PC + 4 (or with branch/jump target).
- Can be stalled if required.

#### 📌 `instruction_memory.v`
- ROM storing instructions.
- Indexed using the PC.
- Output goes to the IF/ID pipeline register.

#### 📌 `if_stage.v`
- Coordinates PC increment, branch/jump selection, and instruction fetch.

#### 📌 `if_id.v`
- Pipeline register that holds PC and instruction for the next stage (ID).

---

### 🟨 2. Instruction Decode (ID) Stage

#### 📌 `register_file.v`
- 32 general-purpose 32-bit registers.
- Supports dual-read and single-write per clock cycle.

#### 📌 `control_unit.v`
- Decodes opcode and generates control signals for the datapath.

#### 📌 `sign_extender.v`
- Extends 16-bit immediate values to 32 bits (sign-extended).

#### 📌 `id_stage.v`
- Prepares operands, control signals, and passes them to the EX stage.

#### 📌 `id_ex.v`
- Pipeline register that stores decoded instruction fields and control signals.

---

### 🟥 3. Execute (EX) Stage

#### 📌 `alu.v`
- Performs arithmetic and logic operations (add, sub, and, or, slt, etc.).

#### 📌 `alu_control.v`
- Maps instruction function codes to specific ALU operations.

#### 📌 `forwarding_unit.v`
- Resolves data hazards by forwarding results from later stages.

#### 📌 `ex_stage.v`
- Selects operands (register or immediate), performs ALU operation, computes branch target.

#### 📌 `ex_mem.v`
- Pipeline register that passes ALU results and control signals to MEM stage.

---

### 🟦 4. Memory Access (MEM) Stage

#### 📌 `data_memory.v`
- Read/write memory module for `lw` and `sw` instructions.

#### 📌 `mem_stage.v`
- Performs memory access if needed, otherwise passes results forward.

#### 📌 `mem_wb.v`
- Pipeline register to pass data or ALU result to WB stage.

---

### 🟪 5. Write Back (WB) Stage

#### 📌 `wb_stage.v`
- Final stage that writes result (from memory or ALU) to the register file.

---

### 🧠 6. Supporting Modules

#### 📌 `hazard_detection_unit.v`
- Detects load-use hazards and stalls the pipeline if needed.

#### 📌 `branch_control.v`
- Evaluates branch conditions (e.g., for `beq`) and signals branch taken or not.

#### 📌 `mux.v` (various)
- Used throughout to select between operands, results, PC paths, etc.

#### 📌 `top_module.v`
- Top-level file that integrates all stages and modules.
- Handles clocking, reset, and instruction/data flow through the pipeline.

---

### 🧪 7. Testbenches

#### 📌 `tb/top_tb.v`
- Provides clock, reset, and instruction memory initialization.
- Runs test programs and captures outputs for waveform analysis.

---

Let me know if you'd like a flow diagram or to autogenerate module templates from this list.



Reference :
https://www.saspublishers.com/article/18696/download/

