#include <unistd.h>

int main() {
	char *buf[24];
	int bytes_read;
	while ((bytes_read = read(0, buf, 64)) > 0) {
		write(1, buf, bytes_read);
	}
	return 0;
}
