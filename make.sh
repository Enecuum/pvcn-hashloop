#!/bin/bash

rm out/*
gcc -maes -O3 -c src/slow-hash.c -o out/slow-hash.o
gcc -maes -O3 -c src/hash.c -o out/hash.o
gcc -maes -O3 -c src/oaes_lib.c -o out/oaes_lib.o
gcc -maes -O3 -c src/aesb.c -o out/aesb.o
gcc -maes -O3 -c src/jh.c -o out/jh.o
gcc -maes -O3 -c src/blake256.c -o out/blake256.o
gcc -maes -O3 -c src/skein.c -o out/skein.o
gcc -maes -O3 -c src/hash-extra-blake.c -o out/hash-extra-blake.o
gcc -maes -O3 -c src/hash-extra-jh.c -o out/hash-extra-jh.o
gcc -maes -O3 -c src/hash-extra-skein.c -o out/hash-extra-skein.o
gcc -maes -O3 -c src/hash-extra-groestl.c -o out/hash-extra-groestl.o
gcc -maes -O3 -c src/groestl.c -o out/groestl.o
g++ -O3 out/slow-hash.o out/aesb.o out/hash.o out/groestl.o out/blake256.o out/skein.o out/jh.o out/oaes_lib.o out/hash-extra-groestl.o out/hash-extra-blake.o out/hash-extra-jh.o out/hash-extra-skein.o hashloop/hashloop.cpp -o slow-hash.out
