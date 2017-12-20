all:
	rm -f slow-hash.o pvcn_hashloop.o pvcn_hashloop.hi slow-hash.c
	ghc --make macro
	expand slow-hash.c.macro | ./macro > slow-hash.c
	#ghc -with-rtsopts="-N4" -threaded --make pvcn_hashloop.hs slow-hash.c -optc -maes -optc -mmmx -optc -mavx -optc -ggdb hash.c aesb.c oaes_lib.c hash-extra-blake.c hash-extra-groestl.c hash-extra-jh.c hash-extra-skein.c blake256.c groestl.c jh.c skein.c
	ghc --make pvcn_hashloop.hs slow-hash.c -optc -maes -optc -mmmx -optc -mavx -optc -ggdb hash.c aesb.c oaes_lib.c hash-extra-blake.c hash-extra-groestl.c hash-extra-jh.c hash-extra-skein.c blake256.c groestl.c jh.c skein.c
