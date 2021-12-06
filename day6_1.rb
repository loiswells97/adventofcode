file_data = File.read("day6.txt").split

fishes=file_data.shift.split(',').map(&:to_i)


(1..80).each do |index|
  puts("Day #{index}")
  new_fish=0
  fishes=fishes.map do |fish|
    # if fish<7
    #   fish-=1
    # else
    #   fish-=1
    # end
    fish-=1

    if fish%7==0 && fish<=0
      new_fish+=1
    end
    fish
  end
  # puts(fishes)
  # puts(new_fish)
  # puts(fishes.length)
  if index<80
    (1..new_fish).each do
      fishes << 9
    end
  end
  puts(fishes)
end

puts(fishes.length)
