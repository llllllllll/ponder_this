// Joe Jevnik

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

typedef unsigned int u_int;

extern u_int pairs[][] = {{1,1},{2,2},{5,5},{6,9},{8,8},{9,6}};

extern u_int flippables[6] = {1,2,5,6,8,9};

bool is_flippable(u_int num[],u_int digits){
    bool f;
    for (u_int n = 0;n < digits;n++){
	f = false;
	for (u_int m = 0;m < 6;m++){
	    if (num[n] == flippables[m]){
		break;
	    }
	}
	if (!f){
	    return false;
	}
    }
    return true;
}
