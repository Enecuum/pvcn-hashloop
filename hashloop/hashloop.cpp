// hashloop.cpp: определяет точку входа для консольного приложения.
//

#include "../src/slow-hash.h"
#include <memory.h>
// #include <stdio.h>

#include <chrono>
#include <iostream>

/*
extern "C" void pvcn_hashloop_hw(const void *data, size_t length
	, int maxFragments, int position
	, uint64_t *keccak_state, uint8_t *hash, int *fragments);
*/

uint64_t timestamp() {
	std::chrono::duration<double, std::milli> ms = std::chrono::system_clock::now().time_since_epoch();
	return ms.count();
}

int main()
{
	char data[] = { 0 };
	const int maxFragments = 20;
	int position = 0;
	uint8_t hash[32*maxFragments];
	memset(hash, 0, sizeof(hash));
	int fragments = 1;
	auto t1 = timestamp();
	pvcn_hashloop_hw(data, 0, maxFragments, position, NULL, hash, &fragments);
	auto t2 = timestamp();
	char hash4[] = "\x1c\x77\xb9\x50\xbe\xed\x14\x8c\xbf\x27\x78\x38\x57\xc3\x87\x53\xd4\x29\x0f\x57\x52\x17\x5b\x2a\x88\xda\x73\xb2\x61\x8a\x14\x17";
	// static_assert(maxFragments > 4);
	if (0 == memcmp(hash + 32*4, hash4, 32)) {
		std::cout << "self-check OK!" << std::endl;
	} else {
		std::cout << "self-check failed!!!" << std::endl;
	}
	std::cout << "t = " << (t2 - t1) << ", hashrate = " << ((maxFragments-1) * 1000.0 / double(t2 - t1)) << std::endl;
    return 0;
}

