#include <unistd.h>
#include <stdlib.h>

void flag1() {
	write(1, "\n\n[+] Congrats Hacked!\n", 23);
	exit(0);
}

void randfailed() {
	write(1, "\n\nFailed To Generate Random Value\n", 34);
	exit(0);
}

void craifailed() {
	write(1, "\n\nReturn Address Failed Integrity Check\n", 40);
	exit(0);
}

void doit() {
	char buf[24];
	int bytes_read;
	while ((bytes_read = read(0, buf, 64)) > 0) {
		write(1, buf, bytes_read);
	}
}

int main() {
	doit();
	return 0;
}
