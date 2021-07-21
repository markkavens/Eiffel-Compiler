#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

int main(int argc, char* argv[]) {
	if(argc == 1 || argc > 2) {
		printf("Error while converting. No file provided");
		exit(0);
	}
	FILE *ifp, *ofp;
	ifp = fopen(argv[argc-1], "r");
	ofp = fopen("input_converted.e", "w");
	char c;
	while((c = getc(ifp)) != EOF) {
		c = tolower((int)c);
		fprintf(ofp, "%c", c);
	}
	fclose(ifp);
	fclose(ofp);
	return 0;
}

