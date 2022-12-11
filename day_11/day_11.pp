Program day_11;

{ Remember that in Pascal, string indexes start at 1. }
Function ReadStr(Var S: String): String;

Var 
  buffer: string;
Begin
  buffer := '';
  While (S[1] In [' ', ',']) Do
    delete(s, 1, 1);

  While (s <> '') And Not(s[1] In [' ']) Do
    Begin
      buffer := buffer + s[1];
      delete(s, 1, 1);
    End;

  ReadStr := buffer;
End;


{ We pretend negative signs don't exist :) }
Function ReadInt(Var S: String) : int64;

Var 
  buffer: int64;
Begin
  buffer := 0;
  While (S[1] In [' ', ',']) Do
    delete(s, 1, 1);

  While (S <> '') And (S[1] In ['0'..'9']) Do
    Begin
      buffer := buffer * 10;
      buffer := buffer + (ord(S[1]) - ord('0'));
      delete(S, 1, 1);
    End;

  ReadInt := buffer;
End;


{ We pretend negative signs don't exist :) }
Function ReadToInt(Var S: String) : int64;

Begin
  While (S[1] <> '') And Not(S[1] In ['0'..'9']) Do
    delete(S, 1, 1);

  ReadToInt := ReadInt(S);
End;

Type 
  Monkey = Record
    items: array Of int64;
    numItems: int64;
    op: string;
    rhs: string;
    test: int64;
    t: int64;
    f: int64;
  End;

Var 
  line: string;
  lines: array Of string;
  counter: int64;
  monkeys: array Of Monkey;
  monkeysCopy: array Of Monkey;
  numMonkeys: int64;
  prod: int64;
  i: int64;
  j: int64;
  k: int64;
  newMonkey: int64;
  first: int64;
  second: int64;
  worry: int64;
  m: Monkey;
  n: Monkey;
  business: array Of int64;

Begin
  counter := 0;
  prod := 1;
  numMonkeys := 0;
  setlength(lines, 100);
  setlength(monkeys, 10);
  setlength(monkeysCopy, 10);

  While Not eof Do
    Begin
      readln(line);
      lines[counter] := line;
      counter := counter + 1;
    End;

  { Parse monkeys }
  For i := 0 To counter Do
    Begin
      If i Mod 7 = 0 Then
        Begin
          m := Default(Monkey);
          n := Default(Monkey);
          setlength(m.items, 100);
          setlength(n.items, 100);

          { Parse the items }
          line := lines[i + 1];
          m.numItems := 0;
          n.numItems := 0;
          While (line <> '') Do
            Begin
              m.items[m.numItems] := ReadToInt(line);
              n.items[n.numItems] := m.items[m.numItems];

              m.numItems := m.numItems + 1;
              n.numItems := m.numItems;
            End;

          { Parse the operation }
          line := lines[i + 2];
          ReadStr(line);
          ReadStr(line);
          ReadStr(line);
          ReadStr(line);
          m.op := ReadStr(line);
          m.rhs := ReadStr(line);

          n.op := m.op;
          n.rhs := m.rhs;

          { Parse the division test }
          line := lines[i + 3];
          m.test := ReadToInt(line);
          n.test := m.test;
          prod := prod * m.test;

          { Parse the true }
          line := lines[i + 4];
          m.t := ReadToInt(line);
          n.t := m.t;

          { Parse the false }
          line := lines[i + 5];
          m.f := ReadToInt(line);
          n.f := m.f;

          monkeys[numMonkeys] := m;
          monkeysCopy[numMonkeys] := n;
          numMonkeys := numMonkeys + 1;
        End;
    End;

  setlength(business, numMonkeys);
  For i := 0 To (numMonkeys - 1) Do
    business[i] := 0;

  For i := 1 To 20 Do
    Begin
      For j := 0 To (numMonkeys - 1) Do
        Begin
          For k := 0 To (monkeys[j].numItems - 1) Do
            Begin
              business[j] := business[j] + 1;
              If monkeys[j].rhs = 'old' Then
                Begin
                  If monkeys[j].op = '+' Then
                    worry := monkeys[j].items[k] + monkeys[j].items[k]
                  Else
                    If monkeys[j].op = '-' Then
                      worry := monkeys[j].items[k] - monkeys[j].items[k]
                  Else
                    If monkeys[j].op = '*' Then
                      worry := monkeys[j].items[k] * monkeys[j].items[k]
                  Else
                    worry := monkeys[j].items[k] Div monkeys[j].items[k]
                End
              Else
                Begin
                  line := monkeys[j].rhs;
                  first := ReadInt(line);
                  If monkeys[j].op = '+' Then
                    worry := monkeys[j].items[k] + first
                  Else
                    If monkeys[j].op = '-' Then
                      worry := monkeys[j].items[k] - first
                  Else
                    If monkeys[j].op = '*' Then
                      worry := monkeys[j].items[k] * first
                  Else
                    worry := monkeys[j].items[k] Div first
                End;
              ;
              worry := worry Div 3;

              If (worry Mod monkeys[j].test) = 0 Then
                newMonkey := monkeys[j].t
              Else
                newMonkey := monkeys[j].f
              ;

              monkeys[newMonkey].items[monkeys[newMonkey].numItems] := worry;
              monkeys[newMonkey].numItems := monkeys[newMonkey].numItems + 1;

              monkeys[j].items[k] := 0;
            End;
          monkeys[j].numItems := 0;
        End;
    End;


  For i := 0 To (numMonkeys - 1) Do
    Begin
      If business[i] > first Then
        Begin
          second := first;
          first := business[i];
        End
      Else
        If business[i] > second Then
          second := business[i];
    End;

  write('Part 1: ');
  writeln(first * second);

  first := 0;
  second := 0;
  worry := 0;
  newMonkey := 0;
  monkeys := monkeysCopy;
  For i := 0 To (numMonkeys - 1) Do
    business[i] := 0;

  For i := 1 To 10000 Do
    Begin
      For j := 0 To (numMonkeys - 1) Do
        Begin
          For k := 0 To (monkeys[j].numItems - 1) Do
            Begin
              business[j] := business[j] + 1;
              If monkeys[j].rhs = 'old' Then
                Begin
                  If monkeys[j].op = '+' Then
                    worry := monkeys[j].items[k] + monkeys[j].items[k]
                  Else
                    If monkeys[j].op = '-' Then
                      worry := monkeys[j].items[k] - monkeys[j].items[k]
                  Else
                    If monkeys[j].op = '*' Then
                      worry := monkeys[j].items[k] * monkeys[j].items[k]
                  Else
                    worry := monkeys[j].items[k] Div monkeys[j].items[k]
                End
              Else
                Begin
                  line := monkeys[j].rhs;
                  first := ReadInt(line);
                  If monkeys[j].op = '+' Then
                    worry := monkeys[j].items[k] + first
                  Else
                    If monkeys[j].op = '-' Then
                      worry := monkeys[j].items[k] - first
                  Else
                    If monkeys[j].op = '*' Then
                      worry := monkeys[j].items[k] * first
                  Else
                    worry := monkeys[j].items[k] Div first
                End;
              ;

              If (worry Mod monkeys[j].test) = 0 Then
                newMonkey := monkeys[j].t
              Else
                newMonkey := monkeys[j].f
              ;

              worry := worry Mod prod;
              monkeys[newMonkey].items[monkeys[newMonkey].numItems] := worry;
              monkeys[newMonkey].numItems := monkeys[newMonkey].numItems + 1;

              monkeys[j].items[k] := 0;
            End;
          monkeys[j].numItems := 0;
        End;
    End;

  first := 0;
  second := 0;
  For i := 0 To (numMonkeys - 1) Do
    Begin
      If business[i] > first Then
        Begin
          second := first;
          first := business[i];
        End
      Else
        If business[i] > second Then
          second := business[i];
    End;

  write('Part 2: ');
  writeln(first * second);
End.
