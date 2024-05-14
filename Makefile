DBG	= gdb				# debugger
DBG_CMD1= "unset environment"		# debugger commands (initialization)
DBG_CMD2= "set exec-wrapper env 'LD_AUDIT=./magic.so'"
RUNAS	= setarch i686 -3 -R		# x86, 3GB address space, no ASLR
ENV	= env -i LD_AUDIT=./magic.so	# empty environment, LD_AUDIT
CFLAGS	+= -m32 -ggdb3			# x86 (32-bit) code, debug information
					# x86 (32-bit) code, no {PIC, PIE},
					# executable stack, no RELRO
CFLAGS_INIT0= -m32 -no-pie -fno-pic -z execstack -z norelro -Wl,-Ttext=0x400000
CFLAGS_INIT1= $(CFLAGS_INIT0) hlp.o

# phony targets
.PHONY: all clean vcat0_run vcat0_dbg vcat0_exp

# build everything (default target)
all: vcat0 exp0

# run `vcat0'
vcat0_run: vcat0
	$(RUNAS) $(ENV) ./$<
# debug `vcat0'
vcat0_dbg: vcat0 exp0
	$(RUNAS) $(DBG) -iex=$(DBG_CMD1) -iex=$(DBG_CMD2) ./$<
# exploit `vcat0'
vcat0_exp: vcat0 exp0
	./exp0 | $(RUNAS) $(ENV) ./$<

# build the apps
vcat0: vcat0.o
	$(CC) $(CFLAGS_INIT0) $< -o $@

# build the exploits
exp0: exp0.c
	$(CC) $(CFLAGS) $< -o $@

# clean
clean:
	$(RM) exp0 vcat0
