func.func @main() {
  %cst = arith.constant 0: i32
  %3 = util.unfoldable_constant dense<1> : tensor<1024x512xi8>
  %4 = util.unfoldable_constant dense<2> : tensor<512x2048xi8>
  %5 = tensor.empty() : tensor<1024x2048xi32>
  %6 = linalg.fill ins(%cst : i32) outs(%5 : tensor<1024x2048xi32>) -> tensor<1024x2048xi32>
  %8 = linalg.matmul ins(%3, %4 : tensor<1024x512xi8>, tensor<512x2048xi8>) outs(%6 : tensor<1024x2048xi32>) -> tensor<1024x2048xi32>
  %9 = util.optimization_barrier %8 : tensor<1024x2048xi32>
  return
}

