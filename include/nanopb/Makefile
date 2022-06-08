all:
	gcc -c -fPIC inverter.pb.c
	gcc -c -fPIC pb_common.c
	gcc -c -fPIC pb_encode.c
	gcc -c -fPIC pb_decode.c
	ar rcs nanopb.a inverter.pb.o pb_common.o pb_decode.o pb_encode.o
clean:
	rm *.o *.a
