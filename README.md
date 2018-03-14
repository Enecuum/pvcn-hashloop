## PVCN-Hashloop

A library to generate pseudorandom hashes and display hash rate speed at which a device completes the generation. 
The library uses a number of hashing functions to achieve a high security level. The encryption technology is based on the [https://github.com/alxarch/go-cryptonight/tree/master/src](Cryptonight) protocol modified for Proof-of-Work + Proof-of-Activity.


## How to Use

1. Clone the repository
2. Open the terminal and `cd` into the cloned repository folder
3. Set the access permissions for the make.sh: `chmod u+x make.sh`
4. Run the make.sh: `./make.sh` to build the test binary file
5. Run `/.slow-hash.out` to generate a list of hashes. If the generated hashes are identical to the stored set of hashes, you see the reponse "self-check OK!".
