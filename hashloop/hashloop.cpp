// hashloop.cpp: определяет точку входа для консольного приложения.
//

#include "../src/slow-hash.h"
#include <memory.h>

/*
extern "C" void pvcn_hashloop_hw(const void *data, size_t length
	, int maxFragments, int position
	, uint64_t *keccak_state, uint8_t *hash, int *fragments);
*/

int main()
{
	char data[] = { 0 };
	const int maxFragments = 5;
	int position = 0;
	uint8_t hash[32*maxFragments];
	memset(hash, 0, sizeof(hash));
	int fragments = 1;
	pvcn_hashloop_hw(data, 0, maxFragments, position, NULL, hash, &fragments);
    return 0;
}

