file_name = ARGV.size > 0 ? ARGV[0] : "input.txt"

top_three = [0, 0, 0]
curr = 0

def update_top(value, arr)
  if value > arr[0]
    arr[2] = arr[1]
    arr[1] = arr[0]
    arr[0] = value
  elsif value > arr[1]
    arr[2] = arr[1]
    arr[1] = value
  elsif value > arr[2]
    arr[2] = value
  end
end

File.each_line(file_name) do |line|
  if line == ""
    update_top(curr, top_three)
    curr = 0
  else
    curr += line.to_i
  end
end
update_top(curr, top_three)

puts "Part 1: #{top_three[0]}"
puts "Part 2: #{top_three[0] + top_three[1] + top_three[2]}"
