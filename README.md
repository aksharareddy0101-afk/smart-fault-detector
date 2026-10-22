# Smart Fault Detection System

## Overview
This project is a parameterized Verilog watchdog circuit. It monitors a `heartbeat` input and raises `fault` if no heartbeat arrives for the configured timeout.

## Inputs and output
- `clk`: clock input
- `rst`: synchronous active-high reset
- `heartbeat`: activity signal; when high, clears the counter and fault
- `fault`: becomes high after the timeout is reached

## Files
- `rtl/smart_fault_detector.v`: synthesizable design
- `simulation/tb_smart_fault_detector.v`: testbench
- `sta_reports/README.md`: notes on timing-report status
- `screenshots/`: place screenshots here if required

## Simulation
The testbench checks that:
1. A heartbeat keeps/clears `fault`.
2. Missing heartbeat causes `fault` to assert after the timeout.
3. A new heartbeat clears `fault`.

The testbench writes a VCD waveform file named `smart_fault_detector.vcd` when run in a simulator that supports `$dumpfile` and `$dumpvars`.

## Browser-based work completed
The project author reported that simulation and synthesis completed in RTL Bench and exported an SVG waveform. Copy the downloaded SVG into the repository if you want to include it.

## Static Timing Analysis (STA)
Do not treat a `PASS` indicator alone as a complete timing report. The actual timing values, constraints, and timing-library identity still need to be recorded and verified. Add the real report and note the tool/library settings in `sta_reports/` when available. Do not invent timing values or claim SKY130 was used unless the tool explicitly confirms it.

## Suggested next steps
1. Confirm the testbench passes in your simulator.
2. Save the exported waveform SVG in the repository.
3. Obtain a full STA report with the timing library and constraints identified.
4. Upload the project files to GitHub.
