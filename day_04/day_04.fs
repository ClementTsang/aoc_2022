64 constant max-line
create line-buf max-line chars allot

\ Clones the last 4 items
: clone
    4 0 do
        3 roll dup
        3 0 do
            4 roll swap
        loop
    loop
;

: sub_part_one ( s1, e1, s2, e2 -- result )
    rot ( s1, e1, s2, e2 -- s1, s2, e2, e1 )
    <= ( s1, s2, e2, e1 -- s1, s2, r1 ) \ check if e2 <= e1
    -rot ( r1, s1, s2 )
    <= ( r1, r2 ) \ check if s1 <= s2
    and ( return )
;

: part_one_check ( s1, e1, s2, e2 -- result )
    \ We want to calculate (s1 <= s2 && e2 <= e1) || (s1 >= s2 && e2 >= e1)
    \ To be lazy, and check both, just clone + take the range and flip it.

    clone ( s1, e1, s2, e2 -- s1, e1, s2, e2, s1, e1, s2, e2 )
    sub_part_one ( s1, e1, s2, e2, result )
    if
        \ No need to go further.
        drop drop drop drop
        -1
    else
        \ Flip the 4 with rolls and try again
        3 roll 3 roll
        sub_part_one
    then
;

: part_two_check ( s1, e1, s2, e2 -- result )
    \ The first thought that would come to most people is
    \ to just simply check the following, which is easy
    \ to do in most languages:
    \ (s1 <= s2 <= e1)
	\   || (s1 <= e2 <= e1)
	\   || (s2 <= s1 <= e2)
	\   || (s2 <= e1 <= e2)
    \
    \ We use a little trick to make this easier in Forth.
    \ If we look at the above conditions, we note that the
    \ only conditions that make it NOT hold are if
    \ s1 > e2 || e1 < s2.
    \
    \ So, we can just invert this to determine the cases it
    \ does hold - this just means we just need to check if
    \ s1 <= e2 && e1 >= s2, which is easy enough to do in
    \ our limited stack.

    -rot ( s1, e1, s2, e2 -- s1, e2, e1, s2 )

    >= ( s1, e2, e1, s2 -- s1, e2, r1 )
    -rot ( s1, e2, r1 -- r1, s1, e2 )
    <= ( r1, s1, e2 -- r1, r2 )
    and ( result )
;

: load_line ( addr, length -- s1, e1, s2, e2 )
    0. ( addr, length, 0, 0 )
    2swap ( 0, 0, addr, length )
    >number ( s1, new_addr, new_length )
    1 -
    swap ( s1, new_length, new_addr )
    1 +
    swap ( s1, new_addr, new_length )
    2swap
    d>s
    -rot

    \ Repeat for e1
    0.
    2swap
    >number
    1 -
    swap
    1 +
    swap
    2swap
    d>s
    -rot

    \ Repeat for s2
    0.
    2swap
    >number
    1 -
    swap
    1 +
    swap
    2swap
    d>s
    -rot

    \ Repeat for e2
    0.
    2swap
    >number
    swap
    swap
    2swap
    d>s
    -rot

    drop drop \ Drop the addr and length
;

: main
    0
    0
    begin
        \ Load into line ( p1, p2 -- p1, p2, length )
        line-buf max-line stdin read-line throw
    while
        line-buf ( p1, p2, length -- p1, p2, length, addr)
        swap ( p1, p2, length, addr -- p1, p2, addr, length )
        load_line ( p1, p2, addr, length -- p1, p2, s1, e1, s2, e2 )
        clone ( p1, p2, s1, e1, s2, e2  -- p1, p2, s1, e1, s2, e2, s1, e1, s2, e2 )

        part_one_check ( p1, p2, s1, e1, s2, e2, s1, e1, s2, e2 -- p1, p2, s1, e1, s2, e2, r1 )
        6 roll swap ( p1, p2, s1, e1, s2, e2, r1 -- p2, s1, e1, s2, e2, p1, r1 )
        if
            1 +
        else
        then
        
        4 0 do
            4 roll
        loop ( p2, s1, e1, s2, e2, p1  -- p2, p1, s1, e1, s2, e2 )

        part_two_check ( p2, p1, s1, e1, s2, e2 -- p2, p1, r2 )
        2 roll swap ( p2, p1, r2 -- p1, p2, r2 )
        if
            1 +
        else
        then
    repeat
    drop \ Drop the remaining length
    swap \ Swap p1 and p2 to be in the right order
    ." Part 1: " . cr
    ." Part 2: " . cr
;

main
bye