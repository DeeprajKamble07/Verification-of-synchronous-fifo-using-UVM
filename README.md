# Verification-of-synchronous-fifo-using-UVM

Synchronous FIFO Verification using UVM

This project focuses on the functional verification of a Synchronous FIFO (First-In First-Out) design using UVM (Universal Verification Methodology). The goal of the project is to validate correct FIFO behavior under different operating conditions such as write-only, read-only, and simultaneous read/write operations.

Design Overview

The FIFO is a synchronous design operating on a single clock domain. It uses:
1. Write and read pointers to manage memory locations
2. Full and empty flag generation logic
3. Registered read data with one-cycle latency

Verification Environment

The verification environment is developed using SystemVerilog and UVM and follows a layered, reusable UVM architecture consisting of:
1. Sequence & Sequence Item: Generates randomized FIFO transactions (reset, write, read)
2. Sequencer: Controls the flow of transactions to the driver
3. Driver: Drives write/read transactions to the FIFO DUT
4. Monitor: Samples FIFO interface signals and captures read data considering FIFO read latency
5. Scoreboard: Uses a reference queue to verify FIFO ordering and
