## Pre-requisties

As of this writing, all of the code for FA2 has not been upstreamed. So we first checkout the layoutdistribution branch in iree.

```
git checkout layoutdistribution
```

The benchmarking is driven by a python script `fa_runner.py` that can be obtained by cloning the toolbox repo.

```
git clone https://github.com/harsh-nod/toolbox
```

The script is located in the `fa` subfolder of the repo above.

You will also need to install python packages numpy and pytorch (for generating reference outputs to compare against).
pytorch is not required for compiling and benchmarking.

## Compiling, Validating & Benchmarking

Benchmarking:

```
python fa_runner.py -shape 16x16384x128xf16 -spec_file attention_transform_spec.mlir -chip gfx940 -backend rocm -iree_build_dir /home/harmenon/iree-build/ -artifact_dir /home/harmenon/iree/tmp -inline
```

Validating results:

```
python fa_runner.py -shape 16x16384x128xf16 -spec_file attention_transform_spec.mlir -chip gfx940 -backend rocm -iree_build_dir [path to build dir] -artifact_dir [path to where to store asm/other artifacts]
```

To generate asm artifacts, run the following command

```
python fa_runner.py -shape 16x16384x128xf16 -spec_file attention_transform_spec.mlir -chip gfx940 -backend rocm -iree_build_dir /home/harmenon/iree-build/ -artifact_dir /home/harmenon/iree/tmp -inline -d
```
This will generate a *.rocasm file for this particular kernel in the artifact directory.

