#pragma once

#include <stdint.h>
#include <stddef.h>

#if defined(__cplusplus)
extern "C"
{
#endif 

void /*__cdecl*/ pvcn_hashloop_hw(const void *data, size_t length, int maxFragments, uint64_t *keccak_state, uint8_t *hash);
void cn_slow_hash_software(const void *data, size_t length, int maxFragments, uint64_t *keccak_state, uint8_t *hash);
#if defined(__cplusplus)
}
#endif 
