#ifndef __PMLC_DIALECT_TILE_PASSES__
#define __PMLC_DIALECT_TILE_PASSES__

include "mlir/Pass/PassBase.td"

def AlgebraicOpt : Pass<"tile-algebraic-opt", "mlir::func::FuncOp"> {
  let summary = "Algebraic optimizations";
  let constructor = "pmlc::dialect::tile::createAlgebraicOptPass()";
}

def ComputeBounds : Pass<"tile-compute-bounds", "mlir::func::FuncOp"> {
  let summary = "Compute bounds for contractions";
  let constructor = "pmlc::dialect::tile::createComputeBoundsPass()";
}

def ExpandReshape : Pass<"tile-expand-reshape", "mlir::func::FuncOp"> {
  let summary = "Expand reshape and generate contraction";
  let constructor = "pmlc::dialect::tile::createExpandReshapePass()";
}

def Materialize : Pass<"tile-materialize", "mlir::func::FuncOp"> {
  let summary = "Materialize arbitrary-precision values based on type promotion rules";
  let constructor = "pmlc::dialect::tile::createMaterializePass()";
}

def PadRanges : Pass<"tile-pad-ranges", "mlir::func::FuncOp"> {
  let summary = "Pad ranges to make things more even (possibly adding constraints)";
  let constructor = "pmlc::dialect::tile::createPadRangesPass()";
  let options = [
    Option<"minPowerOfTwo", "min-po2", "unsigned", /*default=*/"8",
           "Minimum padding to consider, must be a power of 2">,
    Option<"maxPowerOfTwo", "max-po2", "unsigned", /*default=*/"16",
           "Maximum padding to consider, must be a power of 2">,
    Option<"maxIncrease", "max-increase", "float", /*default=*/"0.05",
           "Maximum allowed increase as a fraction of original size">
  ];
}

def PadConstraints : Pass<"tile-pad-constraints", "mlir::func::FuncOp"> {
  let summary = "Pad outputs to remove constraints on inputs";
  let constructor = "pmlc::dialect::tile::createPadConstraintsPass()";
}

#endif // __PMLC_DIALECT_TILE_PASSES__
