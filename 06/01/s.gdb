set verbose off

break *&_start + 23
commands 1
  set $rdi=1
  set $rsi=0x402000
  set $rdx=0xd
  c
end

run
quit