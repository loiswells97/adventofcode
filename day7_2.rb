file_data = File.read("day7.txt").split

positions=file_data.shift.split(',').map(&:to_i)


max_position=positions.max
min_position=positions.min

position_fuels=(min_position..max_position).map do |new_position|
  positions.inject(0) do |fuel_needed, old_position|
    distance=(new_position-old_position).abs
    fuel_needed+= (distance*(distance+1))/2
  end
end

puts(position_fuels.min)
