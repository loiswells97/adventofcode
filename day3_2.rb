file = File.open('day3.txt')
input = file.readlines.map do |line|
  line.chomp.chars
end

file = File.open('day3.txt')
input_copy = file.readlines.map do |line|
  line.chomp.chars
end

digit_number=0
while input_copy.length>1 do

  transposed_input_copy = input_copy.transpose
  digits=transposed_input_copy[digit_number]
  count=digits.inject(0) {|sum, digit| sum+digit.to_i}

  if count>=input_copy.length.to_f/2
    digit_of_interest="1"
  else
    digit_of_interest="0"
  end
  (0...input_copy.length).each do |index|
    if input_copy[index][digit_number] != digit_of_interest
      input_copy[index]=nil
    end
  end
  digit_number += 1
  input_copy=input_copy.compact
end

oxygen_digits=input_copy[0]

digit_number=0
while input.length>1 do

  transposed_input = input.transpose
  digits=transposed_input[digit_number]
  count=digits.inject(0) {|sum, digit| sum+digit.to_i}
  if count>=input.length.to_f/2
    digit_of_interest="0"
  else
    digit_of_interest="1"
  end

  (0...input.length).each do |index|
    if input[index][digit_number] != digit_of_interest

      input[index]=nil
    end
  end
  digit_number += 1
  input=input.compact
end

co2_digits=input[0]

oxygen=oxygen_digits.join.to_i(2)
co2=co2_digits.join.to_i(2)

puts(oxygen*co2)
