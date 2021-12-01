file = File.open('day1.txt')

input = file.readlines.map(&:chomp)

# input=[1,2,3,4,5,6]

three_measurements=input[0..2]
input=input[3..-1]
puts(three_measurements)

answer=input.inject(0) do |total, entry|
    if entry.to_i>three_measurements[0].to_i
      total +=1
    end
    three_measurements.shift
    three_measurements << entry
    puts(three_measurements)
    total
end

puts(answer)
