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

define aesv1_printtag
    b *0x4011d1
    r
    ra
    q
    y
end

define aesv2_printtag
    b *0x4011da
    r
    ra
    q
    y
end

define aesv3_printtag
    b *0x4011f2
    r
    ra
    q
    y
end

define aesv4_printtag
    b *0x40120a
    r
    ra
    q
    y
end

define general
    la asm
    la regs
    b doit
    r
end

aesv4_printtag