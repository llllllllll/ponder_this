// Joe Jevnik
// 16.11.2013

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <gmp.h>

typedef unsigned int u_int;
typedef unsigned long long int u_llong;

bool is_flippable(char*);
bool is_found(char*);
char *find_n(char**,u_int);

// The flippable pairs.
static char *pairs[] = {"00","11","22","55","69","88","96"};

// The flippable characters
static char flippables[] = "01235689";

// Returns true if the number is flippable.
bool is_flippable(char *str){
    mpz_t n;
    bool f;
    char b[32];
    u_int digits;
    mpz_init_set_ui(n,atoi(str));
    mpz_mul(n,n,n);
    digits = gmp_sprintf(b,"%Zu",n);
    mpz_clear(n);
    for (u_int n = 0;n < digits;n++){
	f = false;
	for (u_int m = 0;m < 7;m++){
	    if (b[n] == flippables[m]){
		f = true;
		break;
	    }
	}
	if (!f){
	    return false;
	}
    }
    return 1;
}

// Returns whether or not str matches the criteria.
bool is_found(char *str){
    u_llong val;
    sscanf(str,"%llu",&val);
    if (val && val % 2011 == 0 && str[0] != '0' && is_flippable(str)){
	return true;
    }
    return false;
}

// Returns the string that represents the first element that matches all the
// criteria
char *find_n(char **arr,u_int elemc){
    char *ans;
    char **next_arr = malloc(elemc * 6 * sizeof(char*));
    for (int n = 0;n < elemc;n++){
	if (is_found(arr[n])){
	    ans = strdup(arr[n]);
	    for (int m = 0;m < elemc;m++){
		free(arr[m]);
	    }
	    free(arr);
	    return ans;
	}
    }
    for (int n = 0;n < elemc;n++){
	for (int m = 0;m < 6;m++){
	    next_arr[6 * n + m] = malloc((strlen(arr[n]) + 3) * sizeof(char));
	    sprintf(next_arr[6 * n + m],"%c%s%c",
		    pairs[m][0],arr[n],pairs[m][1]);
	}
	free(arr[n]);
    }
    free(arr);
    return find_n(next_arr,elemc * 6);
}

int main(){
    char **seed = malloc(12 * sizeof(char*));
    seed[0]  = strdup("0");
    seed[1]  = strdup("1");
    seed[2]  = strdup("2");
    seed[3]  = strdup("5");
    seed[4]  = strdup("8");
    seed[5]  = strdup("00");
    seed[6]  = strdup("11");
    seed[7]  = strdup("22");
    seed[8]  = strdup("55");
    seed[9]  = strdup("69");
    seed[10] = strdup("88");
    seed[11] = strdup("96");
    printf("ANS: %s\n",find_n(seed,12));
    return EXIT_SUCCESS;
}
