# enhanced-processor-fpga-p2
Enhanced processor design and FPGA implementation using SystemVerilog with two updated features.

## Overview

This project implements an enhanced processor using SystemVerilog
for FPGA implementation.

The processor integrates memory, basic I/O peripherals, and
conditional branch instructions.

## Features

- Processor datapath and control logic
- 128-word × 9-bit RAM
- MIF-based memory initialization
- Conditional branch instructions: `brne`, `brlt`
- Switch, LED, and 7-segment display interface
- 50 MHz clock operation
- Functional simulation and RTL verification

## Tools

- SystemVerilog
- Intel Quartus
- ModelSim
- FPGA Development Board

## Project Structure

```text
src/          SystemVerilog source files
simulation/   Testbench and simulation files
memory/       MIF files
screenshots/  Waveforms and RTL Viewer results