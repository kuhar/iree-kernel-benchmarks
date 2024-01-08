#! /usr/bin/env bash

set -eou pipefail

readonly BUILD_DIR="$(realpath $1)"
shift

readonly BENCHMARK="$(realpath $1)"
shift

readonly TARGET="$1"
shift

readonly IREE_COMPILE="${BUILD_DIR}/tools/iree-compile"
readonly IREE_BENCHMARK="${BUILD_DIR}/tools/iree-benchmark-module"

readonly ITERS="$1"
shift

set -x

TARGET_FLAGS=()

if [[ $TARGET =~ "vulkan" ]]; then
  TARGET_FLAGS=("--iree-hal-target-backends=vulkan-spirv" "--iree-vulkan-target-triple=rdna3-7900-linux")
elif [[ $TARGET =~ "rocm" ]]; then
  TARGET_FLAGS=("--iree-hal-target-backends=rocm" "--iree-rocm-target-chip=gfx940")
fi


"${IREE_COMPILE}" "${BENCHMARK}" \
  --iree-hal-benchmark-dispatch-repeat-count="${ITERS}" \
  "${TARGET_FLAGS[@]}" \
  -o benchmark.vmfb "$@"

# spirv-cross -V dumps/*.spv || spirv-dis dumps/*.spv

"${IREE_BENCHMARK}" --module=benchmark.vmfb --device="$TARGET" --device_allocator=caching --function=main \
  --batch_size="${ITERS}"

