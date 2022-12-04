\ Very stripped-down version.

64 constant max-line
create line-buf max-line chars allot

: main
    0 0
    begin
        line-buf max-line stdin read-line throw
    while
        line-buf swap 4 0 do 0 0 2swap >number 1 - swap 1 + swap 2swap drop -rot loop drop drop 4 0 do 3 roll dup 3 0 do 4 roll swap loop loop \ Load line, prep
        4 0 do 3 roll dup 3 0 do 4 roll swap loop loop rot <= -rot <= and if drop drop drop drop -1 else 3 roll 3 roll rot <= -rot <= and then 6 roll swap if 1 + else then 4 0 do 4 roll loop \ Part 1
        -rot >= -rot <= and 2 roll swap if 1 + else then \ Part 2
    repeat drop swap
    ." Part 1: " . cr ." Part 2: " . cr
;
main
bye