#dynamic_sz = 16384 : index
!dynamic_matrix = tensor<16384x4096xf16>

func.func @main() {
  %cst = arith.constant 0.000000e+00 : f16
  %cstSz = arith.constant #dynamic_sz
  %2 = util.optimization_barrier %cstSz : index
  %3 = util.unfoldable_constant dense<1.0> : !dynamic_matrix
  %4 = util.unfoldable_constant dense<1.0> : tensor<32000x4096xf16>
  %5 = tensor.empty(%2) : tensor<?x32000xf16>
  %6 = linalg.fill ins(%cst : f16) outs(%5 : tensor<?x32000xf16>) -> tensor<?x32000xf16>
  %7 = tensor.cast %4 : tensor<32000x4096xf16> to tensor<?x4096xf16>
  %8 = linalg.matmul_transpose_b ins(%7, %4 : tensor<?x4096xf16>, tensor<32000x4096xf16>) outs(%6 : tensor<?x32000xf16>) -> tensor<?x32000xf16>
  %9 = util.optimization_barrier %8 : tensor<?x32000xf16>
  return
}

