all:
	arm-none-eabi-gcc -c -fPIC inverter.pb.c
	arm-none-eabi-gcc -c -fPIC pb_common.c
	arm-none-eabi-gcc -c -fPIC pb_encode.c
	arm-none-eabi-gcc -c -fPIC pb_decode.c
	arm-none-eabi-ar rcs nanopb.a inverter.pb.o pb_common.o pb_decode.o pb_encode.o
clean:
	rm *.o *.a
