#include <iostream>
#include <vector>
using namespace std;
const int RESULTS_COUNT = 6;
int main(int argc,char **argv) {
	srand(atoi(argv[1]));
	vector<unsigned char> values;	
	values.push_back(0);
	for(int i=0;i<2;i++) {
			values.push_back(rand()%64);
	}
	unsigned char buffer[100];
	for(int i=0;i<RESULTS_COUNT;i++)
			buffer[i] = values[rand()%values.size()];
	FILE *fp;
	fp = fopen(argv[2], "wb");
	fwrite(buffer,sizeof(unsigned char),RESULTS_COUNT,fp); 
	fclose(fp);	

}
