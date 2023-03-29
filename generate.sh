#!/bin/sh

set -e

generate_proof() {
  CIRCUIT="$(pwd)/build/$1"
  CIRCUIT_JS="$(pwd)/build/$1/$1_js"

  node $CIRCUIT_JS/generate_witness.js $CIRCUIT_JS/$1.wasm $CIRCUIT/params/input.json $CIRCUIT_JS/witness.wtns

  snarkjs groth16 prove $CIRCUIT/$1_final.zkey $CIRCUIT_JS/witness.wtns $CIRCUIT/params/proof.json $CIRCUIT/params/public.json

  snarkjs groth16 verify $CIRCUIT/$1_key.json $CIRCUIT/params/public.json $CIRCUIT/params/proof.json
}

generate_proof $1
