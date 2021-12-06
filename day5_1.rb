require 'set'

file_data = File.open("day5.txt")

coords=file_data.readlines.map do |line|
  coord_strings=line.chomp.split(' -> ')
  [coord_strings[0].split(',').map(&:to_i), coord_strings[1].split(',').map(&:to_i)]

end
puts(coords[0].flatten.join(' '))
# coords.each do |coord_pair|
#   if coord_pair[0][0]!=coord_pair[1][0] || coord_pair[1][0] != coord_pair[1][1]
#     coords.delete

crossing_points=Set.new

vertical_lines=coords.find_all{|coord_pair| coord_pair[0][0]==coord_pair[1][0]}
horizontal_lines=coords.find_all{|coord_pair| coord_pair[0][1] == coord_pair[1][1]}

vertical_lines.each do |vertical_line|
  x=vertical_line[0][0]
  y1= vertical_line[0][1]<vertical_line[1][1] ? vertical_line[0][1] : vertical_line[1][1]
  y2= vertical_line[1][1]>vertical_line[0][1] ? vertical_line[1][1] : vertical_line[0][1]

  horizontal_lines.each do |horizontal_line|
    y=horizontal_line[0][1]
    x1=horizontal_line[0][0]<horizontal_line[1][0] ? horizontal_line[0][0] : horizontal_line[1][0]
    x2=horizontal_line[1][0]>horizontal_line[0][0] ? horizontal_line[1][0] : horizontal_line[0][0]

    if x>=x1 && x<=x2 && y>=y1 && y<=y2
      crossing_points.add([x,y])

    end
  end
end

# crossing_points.each do |point|
#   puts(point.join(','))
# end

vertical_lines.each do |line1|
  vertical_lines.each do |line2|
    if line1[0][0]==line2[0][0] && line1 != line2
      x=line1[0][0]
      y1=line1[0][1]<line1[1][1] ? line1[0][1] : line1[1][1]
      y2=line1[1][1]>line1[0][1] ? line1[1][1] : line1[0][1]
      y3=line2[0][1]<line2[1][1] ? line2[0][1] : line2[1][1]
      y4=line2[1][1]>line2[0][1] ? line2[1][1] : line2[0][1]

      # y=[y1,y3].max
      # while y<=[y2,y4].min do
      #   crossing_points.add([x,y])
      #   y+=1
      ([y1, y3].max..[y2, y4].min).each do |y|
        crossing_points.add([x,y])
      end
    end
  end
end

horizontal_lines.each do |line1|
  horizontal_lines.each do |line2|
    if line1[0][1]==line2[0][1] && line1 != line2
      y=line1[0][1]
      x1=line1[0][0]<line1[1][0] ? line1[0][0] : line1[1][0]
      x2=line1[1][0]>line1[0][0] ? line1[1][0] : line1[0][0]
      x3=line2[0][0]<line2[1][0] ? line2[0][0] : line2[1][0]
      x4=line2[1][0]>line2[0][0] ? line2[1][0] : line2[0][0]
      ([x1, x3].max..[x2, x4].min).each do |x|
        crossing_points.add([x,y])
      end
    end
  end
end

crossing_points.each do |point|
  puts(point.join(','))
end

puts(crossing_points.size)
