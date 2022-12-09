defmodule Day_09 do
  def simulate(inst, size) do
    # A snake is represented as a tuple of {x, y}

    {_snake, visited} =
      List.foldl(
        inst,
        {0..(size - 1) |> Enum.map(fn _ -> {0, 0} end), MapSet.new([{0, 0}])},
        fn {direction, amount}, {s, v} ->
          List.foldl(
            Enum.to_list(0..(amount - 1)),
            {s, v},
            fn _, {s, v} ->
              head = Enum.at(s, 0)

              new_snake =
                case direction do
                  "U" ->
                    List.replace_at(s, 0, {elem(head, 0), elem(head, 1) + 1})

                  "D" ->
                    List.replace_at(s, 0, {elem(head, 0), elem(head, 1) - 1})

                  "L" ->
                    List.replace_at(s, 0, {elem(head, 0) - 1, elem(head, 1)})

                  "R" ->
                    List.replace_at(s, 0, {elem(head, 0) + 1, elem(head, 1)})

                  _ ->
                    # Should never occur.
                    nil
                end

              new_s =
                List.foldl(
                  Enum.to_list(0..(size - 2)),
                  new_snake,
                  fn i, s ->
                    head = Enum.at(s, i)
                    tail = Enum.at(s, i + 1)

                    head_x = elem(head, 0)
                    head_y = elem(head, 1)

                    tail_x = elem(tail, 0)
                    tail_y = elem(tail, 1)

                    if abs(head_x - tail_x) <= 1 && abs(head_y - tail_y) <= 1 do
                      s
                    else
                      tail_x =
                        if head_x > tail_x do
                          tail_x + 1
                        else
                          if head_x < tail_x do
                            tail_x - 1
                          else
                            tail_x
                          end
                        end

                      tail_y =
                        if head_y > tail_y do
                          tail_y + 1
                        else
                          if head_y < tail_y do
                            tail_y - 1
                          else
                            tail_y
                          end
                        end

                      List.replace_at(s, i + 1, {tail_x, tail_y})
                    end
                  end
                )

              {new_s, v |> MapSet.put(List.last(new_s))}
            end
          )
        end
      )

    Enum.count(visited)
  end
end

file_name =
  case Enum.fetch(System.argv(), 0) do
    {:ok, f} -> f
    :error -> "input.txt"
  end

IO.puts("Using file path: " <> file_name)

case File.read(file_name) do
  {:ok, contents} ->
    inst =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        s = line |> String.split(" ", trim: true)
        dir = Enum.fetch!(s, 0)

        amt =
          case Integer.parse(Enum.fetch!(s, 1)) do
            {val, _} -> val
            _ -> 0
          end

        {dir, amt}
      end)

    IO.puts("Part 1: " <> Integer.to_string(Day_09.simulate(inst, 2)))
    IO.puts("Part 2: " <> Integer.to_string(Day_09.simulate(inst, 10)))

  :error ->
    "???"
end
