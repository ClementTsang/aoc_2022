\ Very stripped-down version.

64 constant max-line
create line-buf max-line chars allot

: clone_four
    4 0 do
        3 roll dup 
        3 0 do 
            4 roll swap
        loop 
    loop
;

: part_one_check
    clone_four
    rot <= -rot <= and
    if drop drop drop drop -1 else 3 roll 3 roll rot <= -rot <= and then
;

: part_two_check
    -rot >= -rot <= and
;

: load_line
    4 0 do 
        0 0
        2swap
        >number
        1 - swap 1 + swap 2swap drop
        -rot 
    loop
    drop drop
;

: main
    0 0
    begin
        line-buf max-line stdin read-line throw
    while
        line-buf swap load_line clone_four

        part_one_check
        6 roll swap if 1 + else then 4 0 do 4 roll loop

        part_two_check
        2 roll swap if 1 + else then
    repeat
    drop swap
    ." Part 1: " . cr
    ." Part 2: " . cr
;

main
bye