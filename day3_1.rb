file = File.open('day3.txt')

input = file.readlines.map do |line|
  line.chomp.chars
end

transposed_input=input.transpose

counter = transposed_input.map do |digits|
  digits.inject(0) {|sum, digit| sum+digit.to_i}
end

gamma_digits = counter.map do |total|
  if total>input.length/2
    "1"
  else
    "0"
  end
end

epsilon_digits = gamma_digits.map {|gamma_digit| (1-gamma_digit.to_i).to_s}

gamma=gamma_digits.join.to_i(2)
epsilon=epsilon_digits.join.to_i(2)
