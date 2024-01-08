func.func @main() {
  %c64 = arith.constant 64 : index
  %c8192 = arith.constant 8192 : index
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f16
  %2 = util.unfoldable_constant dense<1> : tensor<4096x32x128xi4>
  %3 = util.unfoldable_constant dense<1.0> : tensor<4096x32xf16>
  %4 = util.unfoldable_constant dense<1.0> : tensor<4096x32xf16>
  %5 = util.unfoldable_constant dense<1.0> : tensor<32x128xf16>

  %9 = tensor.empty() : tensor<4096xf16>
  %10 = tensor.empty() : tensor<4096x32x128xf16>
  %11 = linalg.fill ins(%cst : f16) outs(%9 : tensor<4096xf16>) -> tensor<4096xf16>
  %12 = linalg.generic {
    indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d1, d2)>,
                     affine_map<(d0, d1, d2) -> (d0, d1)>,
                     affine_map<(d0, d1, d2) -> (d0, d1)>,
                     affine_map<(d0, d1, d2) -> (d0, d1, d2)>],
    iterator_types = ["parallel", "parallel", "parallel"]
  } ins(%2, %3, %4 : tensor<4096x32x128xi4>, tensor<4096x32xf16>, tensor<4096x32xf16>)
    outs(%10 : tensor<4096x32x128xf16>) {
  ^bb0(%in: i4, %in_0: f16, %in_1: f16, %out: f16):
    %14 = arith.extui %in : i4 to i32
    %15 = arith.uitofp %14 : i32 to f16
    %16 = arith.subf %15, %in_1 : f16
    %17 = arith.mulf %16, %in_0 : f16
    linalg.yield %17 : f16
  } -> tensor<4096x32x128xf16>
  %13 = linalg.generic {
    indexing_maps = [affine_map<(d0, d1, d2) -> (d1, d2)>,
                     affine_map<(d0, d1, d2) -> (d0, d1, d2)>,
                     affine_map<(d0, d1, d2) -> (d0)>],
    iterator_types = ["parallel", "reduction", "reduction"]
  } ins(%5, %12 : tensor<32x128xf16>, tensor<4096x32x128xf16>)
    outs(%11 : tensor<4096xf16>) {
  ^bb0(%in: f16, %in_0: f16, %out: f16):
    %14 = arith.mulf %in, %in_0 : f16
    %15 = arith.addf %14, %out : f16
    linalg.yield %15 : f16
  } -> tensor<4096xf16>

  util.optimization_barrier %13 : tensor<4096xf16>
  return
}
