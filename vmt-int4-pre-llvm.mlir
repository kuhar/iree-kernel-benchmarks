// -----// IR Dump After GPUCheckResourceUsage (iree-codegen-gpu-check-resource-usage) //----- //
module {
  func.func @main_dispatch_0_generic_4096x32x128_f16() {
    %cst = arith.constant dense<0> : vector<1x8xi4>
    %c-128 = arith.constant -128 : index
    %c8 = arith.constant 8 : index
    %c-1 = arith.constant -1 : index
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<1x8xf16>
    %cst_1 = arith.constant dense<0.000000e+00> : vector<2xf16>
    %c1_i32 = arith.constant 1 : i32
    %c64_i32 = arith.constant 64 : i32
    %c2_i32 = arith.constant 2 : i32
    %c4_i32 = arith.constant 4 : i32
    %c8_i32 = arith.constant 8 : i32
    %c16_i32 = arith.constant 16 : i32
    %c32_i32 = arith.constant 32 : i32
    %c4 = arith.constant 4 : index
    %c32 = arith.constant 32 : index
    %cst_2 = arith.constant 0.000000e+00 : f16
    %0 = gpu.thread_id  x
    %1 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<4096x32x128xi4, #gpu.address_space<global>>
    memref.assume_alignment %1, 64 : memref<4096x32x128xi4, #gpu.address_space<global>>
    %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<4096x32xf16, #gpu.address_space<global>>
    memref.assume_alignment %2, 64 : memref<4096x32xf16, #gpu.address_space<global>>
    %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<4096x32xf16, #gpu.address_space<global>>
    memref.assume_alignment %3, 64 : memref<4096x32xf16, #gpu.address_space<global>>
    %4 = hal.interface.binding.subspan set(0) binding(3) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<32x128xf16, #gpu.address_space<global>>
    memref.assume_alignment %4, 64 : memref<32x128xf16, #gpu.address_space<global>>
    %5 = hal.interface.binding.subspan set(0) binding(4) type(storage_buffer) alignment(64) offset(%c0) : memref<4096xf16, #gpu.address_space<global>>
    memref.assume_alignment %5, 64 : memref<4096xf16, #gpu.address_space<global>>
    %workgroup_id_x = hal.interface.workgroup.id[0] : index
    %6 = arith.cmpi slt, %0, %c0 : index
    %7 = arith.subi %c-1, %0 : index
    %8 = arith.select %6, %7, %0 : index
    %9 = arith.divsi %8, %c16 : index
    %10 = arith.subi %c-1, %9 : index
    %11 = arith.select %6, %10, %9 : index
    %12 = arith.muli %0, %c8 : index
    %13 = arith.muli %11, %c-128 : index
    %14 = arith.addi %12, %13 : index
    %15 = scf.for %arg0 = %c0 to %c32 step %c4 iter_args(%arg1 = %cst_0) -> (vector<1x8xf16>) {
      %56 = arith.addi %arg0, %11 : index
      %57 = vector.load %1[%workgroup_id_x, %56, %14] : memref<4096x32x128xi4, #gpu.address_space<global>>, vector<8xi4>
      %58 = vector.insert %57, %cst [0] : vector<8xi4> into vector<1x8xi4>
      %59 = memref.load %3[%workgroup_id_x, %56] : memref<4096x32xf16, #gpu.address_space<global>>
      %60 = vector.splat %59 : vector<8xf16>
      %61 = vector.insert %60, %cst_0 [0] : vector<8xf16> into vector<1x8xf16>
      %62 = memref.load %2[%workgroup_id_x, %56] : memref<4096x32xf16, #gpu.address_space<global>>
      %63 = vector.splat %62 : vector<8xf16>
      %64 = vector.insert %63, %cst_0 [0] : vector<8xf16> into vector<1x8xf16>
      %65 = vector.load %4[%56, %14] : memref<32x128xf16, #gpu.address_space<global>>, vector<8xf16>
      %66 = vector.insert %65, %cst_0 [0] : vector<8xf16> into vector<1x8xf16>
      %67 = arith.extui %58 : vector<1x8xi4> to vector<1x8xi32>
      %68 = arith.uitofp %67 : vector<1x8xi32> to vector<1x8xf16>
      %69 = arith.subf %68, %61 : vector<1x8xf16>
      %70 = arith.mulf %69, %64 : vector<1x8xf16>
      %71 = arith.mulf %66, %70 : vector<1x8xf16>
      %72 = arith.addf %71, %arg1 : vector<1x8xf16>
      scf.yield %72 : vector<1x8xf16>
    }
    %16 = vector.extract %15[0] : vector<8xf16> from vector<1x8xf16>
    %17 = vector.extract_strided_slice %16 {offsets = [0], sizes = [4], strides = [1]} : vector<8xf16> to vector<4xf16>
    %18 = vector.reduction <add>, %17 : vector<4xf16> into f16
    %19 = vector.insert %18, %cst_1 [0] : f16 into vector<2xf16>
    %20 = vector.extract_strided_slice %16 {offsets = [4], sizes = [4], strides = [1]} : vector<8xf16> to vector<4xf16>
    %21 = vector.reduction <add>, %20 : vector<4xf16> into f16
    %22 = vector.insert %21, %19 [1] : f16 into vector<2xf16>
    %23 = vector.bitcast %22 : vector<2xf16> to vector<1xi32>
    %24 = vector.extract %23[0] : i32 from vector<1xi32>
    %shuffleResult, %valid = gpu.shuffle  xor %24, %c1_i32, %c64_i32 : i32
    %25 = vector.splat %shuffleResult : vector<1xi32>
    %26 = vector.bitcast %25 : vector<1xi32> to vector<2xf16>
    %27 = arith.addf %22, %26 : vector<2xf16>
    %28 = vector.bitcast %27 : vector<2xf16> to vector<1xi32>
    %29 = vector.extract %28[0] : i32 from vector<1xi32>
    %shuffleResult_3, %valid_4 = gpu.shuffle  xor %29, %c2_i32, %c64_i32 : i32
    %30 = vector.splat %shuffleResult_3 : vector<1xi32>
    %31 = vector.bitcast %30 : vector<1xi32> to vector<2xf16>
    %32 = arith.addf %27, %31 : vector<2xf16>
    %33 = vector.bitcast %32 : vector<2xf16> to vector<1xi32>
    %34 = vector.extract %33[0] : i32 from vector<1xi32>
    %shuffleResult_5, %valid_6 = gpu.shuffle  xor %34, %c4_i32, %c64_i32 : i32
    %35 = vector.splat %shuffleResult_5 : vector<1xi32>
    %36 = vector.bitcast %35 : vector<1xi32> to vector<2xf16>
    %37 = arith.addf %32, %36 : vector<2xf16>
    %38 = vector.bitcast %37 : vector<2xf16> to vector<1xi32>
    %39 = vector.extract %38[0] : i32 from vector<1xi32>
    %shuffleResult_7, %valid_8 = gpu.shuffle  xor %39, %c8_i32, %c64_i32 : i32
    %40 = vector.splat %shuffleResult_7 : vector<1xi32>
    %41 = vector.bitcast %40 : vector<1xi32> to vector<2xf16>
    %42 = arith.addf %37, %41 : vector<2xf16>
    %43 = vector.bitcast %42 : vector<2xf16> to vector<1xi32>
    %44 = vector.extract %43[0] : i32 from vector<1xi32>
    %shuffleResult_9, %valid_10 = gpu.shuffle  xor %44, %c16_i32, %c64_i32 : i32
    %45 = vector.splat %shuffleResult_9 : vector<1xi32>
    %46 = vector.bitcast %45 : vector<1xi32> to vector<2xf16>
    %47 = arith.addf %42, %46 : vector<2xf16>
    %48 = vector.bitcast %47 : vector<2xf16> to vector<1xi32>
    %49 = vector.extract %48[0] : i32 from vector<1xi32>
    %shuffleResult_11, %valid_12 = gpu.shuffle  xor %49, %c32_i32, %c64_i32 : i32
    %50 = vector.splat %shuffleResult_11 : vector<1xi32>
    %51 = vector.bitcast %50 : vector<1xi32> to vector<2xf16>
    %52 = arith.addf %47, %51 : vector<2xf16>
    %53 = vector.reduction <add>, %52 : vector<2xf16> into f16
    %54 = arith.addf %53, %cst_2 : f16
    %55 = arith.cmpi eq, %0, %c0 : index
    scf.if %55 {
      memref.store %54, %5[%workgroup_id_x] : memref<4096xf16, #gpu.address_space<global>>
    }
    return
  }
}
