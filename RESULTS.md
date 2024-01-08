# IREE Kernel Benchmarks

Date: 2024-01-08

Author: Jakub Kuderski

## Results vulkan-ubuntu-7900xtx

### VMT

Command: `run.sh ~/iree/build/relass vmt.mlir vulkan://0 512`.

Problem size: (1x4096xf16, 32000x4096xf16) -> 1x32000xf16
Total input/output data: 262.22 MB

Time: 287 us (3489 it/s)
Bandwidth: 913 MB/s

### VMT + dequant

Command: `run.sh ~/iree/build/relass vmt_int4.mlir vulkan://0 1024`.

Problem size: (4096x32x128xi4, 4096x32xf16, 4096x32xf16) -> 4096x32x128xf16 + (32x128xf16, 4096x32x128xf16) -> 4096xf16
Total input/output data: 8.9 MB

Time: 10 us (104036 it/s)
Bandwidth: 926 MB/s

### MMT

Command: `run.sh ~/iree/build/relass mmt.mlir vulkan://0 32`.

Problem size: (?x4096xf16, 32000x4096xf16) -> ?x32000xf16 | with ? = 16384
Total input/output data: 1444.94 MB

Time: 172 ms (5.81 it/s)
Bandwidth: 8395 MB/s

## Results mi300

### Flash Attention 2

Instructions to reproduce are in FA2-repro.md

Problem size: (16x16384x128xf16, 16x16384x128xf16, 16x16384x128xf16) -> (16x16384x128xf16)
Total input/output data: 256 MB

Time: 12 ms (83.333 it/s)
Bandwidth: 21333.3 MB/s

ISA: fa2.rocasm
Pre-LLVM MLIR: fa2-pre-llvm.mlir

Accuracy (error): 0.0045776
