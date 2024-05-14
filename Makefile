DBG	= gdb				                       # debugger
RUNAS	= setarch x86_64 -3 -R	               # x86_64, 3GB address space, no ASLR
CFLAGS	+= -m64 -ggdb3			               # x86_64 (64-bit) code, debug information
CFLAGS_INIT0= -m64 -no-pie -fno-pic -z norelro # x86_64 (64-bit) code, no {PIC, PIE}, no RELRO

.PHONY: all clean vcat0_run vcat0_dbg vcat0_exp

all: vcat0 exp0

vcat0: vcat0.c
	$(CC) $(CFLAGS_INIT0) $< -o $@

exp0: exp0.c
	$(CC) $(CFLAGS) $< -o $@

run: vcat0
	$(RUNAS) ./$<

dbg: vcat0 exp0
	$(RUNAS) $(DBG) ./$<

exp: vcat0 exp0
	./exp0 | $(RUNAS) ./$<

obj: vcat0
	objdump -d vcat0

clean:
	$(RM) exp0 vcat0
