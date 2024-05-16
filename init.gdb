define xmm6
    info registers xmm6
end

define xmm5
    info registers xmm5
end

define xmm4
    info registers xmm4
end

define xmm3
    info registers xmm3
end

define ra
    x/2x $rsp
end

la asm
la regs
b main
r