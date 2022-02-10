set verbose off

break *&check + 67
commands 1
  set $r9d=1
  set $esi=1
  c
end

run
quit