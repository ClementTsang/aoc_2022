with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Unbounded;
with Ada.Strings.Bounded;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Ordered_Sets;
with Ada.Integer_Text_IO;

use Ada.Text_IO;
use Ada.Command_Line;
use Ada.Strings.Unbounded;
use Ada.Strings.Bounded;
use Ada.Integer_Text_IO;

procedure Day_06 is
    package String_Sets is new Ada.Containers.Ordered_Sets
       (Element_Type => Unbounded_String);

    use String_Sets;

    File_Name  : Unbounded_String;
    F          : File_Type;
    Line       : Unbounded_String;
    LineLength : Natural;
    S          : Set;
begin
    if Argument_Count > 0 then
        File_Name := To_Unbounded_String (Argument (1));
    else
        File_Name := To_Unbounded_String ("input.txt");
    end if;

    Put_Line ("Output path: " & To_String (File_Name));

    Open (F, In_File, To_String (File_Name));
    while not End_Of_File (F) loop
        Line       := To_Unbounded_String (Get_Line (F));
        LineLength := Length (Line);

        for I in 1 .. (LineLength - 3) loop
            S.Clear;
            S.Include (To_Unbounded_String (To_String (Line) (I .. I)));
            S.Include
               (To_Unbounded_String (To_String (Line) (I + 1 .. I + 1)));
            S.Include
               (To_Unbounded_String (To_String (Line) (I + 2 .. I + 2)));
            S.Include
               (To_Unbounded_String (To_String (Line) (I + 3 .. I + 3)));

            if S.Length = 4 then
                Put ("Part One: ");
                Put (I + 3);
                New_Line (1);
                exit;
            end if;
        end loop;

        for I in 1 .. (LineLength - 13) loop
            S.Clear;
            for J in I .. I + 13 loop
                S.Include (To_Unbounded_String (To_String (Line) (J .. J)));
            end loop;

            if S.Length = 14 then
                Put ("Part Two: ");
                Put (I + 13);
                New_Line (1);
                exit;
            end if;
        end loop;
    end loop;
    Close (F);
end Day_06;
