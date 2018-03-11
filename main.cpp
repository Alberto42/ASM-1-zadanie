#include <cstdio>
#include <algorithm>
#include <cassert>
#include <cstdlib>
#include <string.h>
using namespace std;
const int BUFFER_SIZE = 10;
int main(int argc,char** argv) {
	FILE *fp;
	unsigned char buffer[BUFFER_SIZE];
	fp=fopen(argv[1], "rb");
	int n = fread(buffer, BUFFER_SIZE, 1, fp);	
	assert(n <= BUFFER_SIZE);
	int previous_zero = -1;
	unsigned char pattern[BUFFER_SIZE];
	int pattern_size=-1;
	for(int i=0;i<n;i++) {
		if (buffer[i] == 0 ) {
			sort(buffer+previous_zero+1,buffer+i);	
			previous_zero=i;
			if (pattern_size == -1) {
				pattern_size = i;
				memcpy(pattern,buffer,pattern_size);
			} else {
				if (pattern_size != i-previous_zero-1)
					return 1;
				if (memcmp(pattern,buffer+previous_zero+1,pattern_size) != 0 ) {
					return 1;
				} 
			}
		}
	}
	if (buffer[n-1] != 0 )
			return 1;
	return 0;
	
}
