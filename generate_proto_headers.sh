#!/bin/sh
# generates header files from .proto message
# copies latest sources from submodule to include/

nanopb/generator/protoc --nanopb_out=include/nanopb/ inverter.proto

cp -p nanopb/pb.h include/nanopb/
cp -p nanopb/pb_common.h include/nanopb/
cp -p nanopb/pb_common.c include/nanopb/
cp -p nanopb/pb_decode.h include/nanopb/
cp -p nanopb/pb_decode.c include/nanopb/
cp -p nanopb/pb_encode.c include/nanopb/
cp -p nanopb/pb_encode.h include/nanopb/

