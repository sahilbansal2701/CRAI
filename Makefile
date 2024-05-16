DBG	= gdb				                       # debugger
RUNAS	= setarch x86_64 -3 -R	               # x86_64, 3GB address space, no ASLR
CFLAGS	+= -m64 -ggdb3			               # x86_64 (64-bit) code, debug information
CFLAGS_INIT0= -m64 -no-pie -fno-pic -z norelro # x86_64 (64-bit) code, no {PIC, PIE}, no RELRO

asm: vcat0.c
	$(CC) $(CFLAGS_INIT0) $< -S

vcat0: vcat0.s
	$(CC) $(CFLAGS_INIT0) $< -o $@

vcat0_aesv1: vcat0_aesv1.s
	$(CC) $(CFLAGS_INIT0) $< -o $@

vcat0_aesv2: vcat0_aesv2.s
	$(CC) $(CFLAGS_INIT0) $< -o $@

vcat0_aesv3: vcat0_aesv3.s
	$(CC) $(CFLAGS_INIT0) $< -o $@

vcat0_aesv4: vcat0_aesv4.s
	$(CC) $(CFLAGS_INIT0) $< -o $@

exp0: exp0.c
	$(CC) $(CFLAGS) $< -o $@

exp0_aesv1: exp0_aesv1.c
	$(CC) $(CFLAGS) $< -o $@

exp0_aesv2: exp0_aesv2.c
	$(CC) $(CFLAGS) $< -o $@

exp0_aesv3: exp0_aesv3.c
	$(CC) $(CFLAGS) $< -o $@

exp0_aesv4: exp0_aesv4.c
	$(CC) $(CFLAGS) $< -o $@

run: vcat0
	$(RUNAS) ./$<

run_aesv1: vcat0_aesv1
	$(RUNAS) ./$<

run_aesv2: vcat0_aesv2
	$(RUNAS) ./$<

run_aesv3: vcat0_aesv3
	$(RUNAS) ./$<

run_aesv4: vcat0_aesv4
	$(RUNAS) ./$<

dbg: vcat0 exp0
	$(RUNAS) $(DBG) -x ./init.gdb ./$< 

dbg_aesv1: vcat0_aesv1 exp0_aesv1
	$(RUNAS) $(DBG) -x ./init.gdb ./$< 

dbg_aesv2: vcat0_aesv2 exp0_aesv2
	$(RUNAS) $(DBG) -x ./init.gdb ./$< 

dbg_aesv3: vcat0_aesv3 exp0_aesv3
	$(RUNAS) $(DBG) -x ./init.gdb ./$< 

dbg_aesv4: vcat0_aesv4 exp0_aesv4
	$(RUNAS) $(DBG) -x ./init.gdb ./$< 

exp: vcat0 exp0
	./exp0 | $(RUNAS) ./$<

exp_aesv1: vcat0_aesv1 exp0_aesv1
	./exp0_aesv1 | $(RUNAS) ./$<

exp_aesv2: vcat0_aesv2 exp0_aesv2
	./exp0_aesv2 | $(RUNAS) ./$<

exp_aesv3: vcat0_aesv3 exp0_aesv3
	./exp0_aesv3 | $(RUNAS) ./$<

exp_aesv4: vcat0_aesv4 exp0_aesv4
	./exp0_aesv4 | $(RUNAS) ./$<

obj: vcat0
	objdump -d vcat0 > vcat0.txt

obj_aesv1: vcat0_aesv1
	objdump -d vcat0_aesv1 > vcat0_aesv1.txt

obj_aesv2: vcat0_aesv2
	objdump -d vcat0_aesv2 > vcat0_aesv2.txt

obj_aesv3: vcat0_aesv3
	objdump -d vcat0_aesv3 > vcat0_aesv3.txt

obj_aesv4: vcat0_aesv4
	objdump -d vcat0_aesv4 > vcat0_aesv4.txt
