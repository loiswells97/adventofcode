file = File.open('day1.txt')

input = file.readlines.map(&:chomp)

puts(input.size)

last_entry=input.shift

answer=input.inject(0) do |total, entry|
    if entry.to_i>last_entry.to_i
      total +=1
    end
    last_entry=entry
    puts(entry)
    total
end

puts(answer)
