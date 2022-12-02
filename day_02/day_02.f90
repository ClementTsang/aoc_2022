program day_02
   integer :: iostat
   integer :: score_1
   integer :: score_2
   integer :: round_1
   integer :: round_2

   character(1) :: opp
   character(1) :: you

   iostat = 0

   score_1 = 0
   score_2 = 0

   open (unit = 1, file = "input.txt", status="old")
   do while (iostat == 0)
      read(1, *, iostat=iostat) opp, you
      if (iostat == 0) then
         if (you == 'X') then
            round_1 = 1
         else if (you == 'Y') then
            round_1 = 2
         else
            round_1 = 3
         end if

         round_2 = 0
         if (opp == 'A') then
            if (you == 'X') then
               round_1 = round_1 + 3
               round_2 = round_2 + 3 + 0
            else if (you == 'Y') then
               round_1 = round_1 + 6
               round_2 = round_2 + 1 + 3
            else if (you == 'Z') then
               round_1 = round_1 + 0
               round_2 = round_2 + 2 + 6
            end if
         else if (opp == 'B') then
            if (you == 'X') then
               round_1 = round_1 + 0
               round_2 = round_2 + 1 + 0
            else if (you == 'Y') then
               round_1 = round_1 + 3
               round_2 = round_2 + 2 + 3
            else if (you == 'Z') then
               round_1 = round_1 + 6
               round_2 = round_2 + 3 + 6
            end if
         else if (opp == 'C') then
            if (you == 'X') then
               round_1 = round_1 + 6
               round_2 = round_2 + 2 + 0
            else if (you == 'Y') then
               round_1 = round_1 + 0
               round_2 = round_2 + 3 + 3
            else if (you == 'Z') then
               round_1 = round_1 + 3
               round_2 = round_2 + 1 + 6
            end if
         end if

         score_1 = score_1 + round_1
         score_2 = score_2 + round_2
      end if
   end do

   print *, "Part 1:", score_1
   print *, "Part 2:", score_2

end program day_02
