file = File.open('day2.txt')

input = file.readlines.map(&:chomp)

final_coords=input.inject([0,0]) do |coords, move|
  move_instructions=move.split
  if move_instructions[0]=='forward'
    coords[1]+=move_instructions[1].to_i
  elsif move_instructions[0]=='down'
    coords[0]+=move_instructions[1].to_i
  else
    coords[0]-=move_instructions[1].to_i
  end
  puts(coords)
  coords
end

puts(final_coords[0]*final_coords[1])
