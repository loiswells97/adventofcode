file_data = File.read("day6.txt").split

fish_stream=file_data.shift.split(',').map(&:to_i)

fishes=(0..6).map do |fish_day|

  fish_stream.count {|fish| fish==fish_day}

end

puts('Initial fishes')
puts(fishes.join(', '))

babies=[0,0]
next_week_fishes=fishes.clone
(1..256/7).each do
  (0..6).each do |index|
    if index==0 || index==1
      next_week_fishes[index]+=babies[index]
    elsif index==5 || index==6
      babies[index-5]=fishes[index]
      next_week_fishes[index]+=fishes[index-2]
    else
      next_week_fishes[index]+=fishes[index-2]
    end
  end
  fishes=next_week_fishes.clone
  puts("After a week the fishes are:")
  puts(fishes.join(', '))
end
puts("The number of fishes are:")
extra_fishes=(0..6).inject(0) {|sum, index| index<256%7 ? sum+fishes[index] : sum}
puts("TOTAL:")
puts(fishes.sum+babies.sum+extra_fishes)
