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

# crossing_points.each do |point|
#   puts(point.join(','))
# end

puts(crossing_points.size)

upwards_diagonals=coords.find_all{|coord_pair|
  (coord_pair[0][0]>coord_pair[1][0] && coord_pair[0][1]>coord_pair[1][1]) || (coord_pair[0][0]>coord_pair[1][0] && coord_pair[0][1]>coord_pair[1][1])
}

downwards_diagonals=coords.find_all{|coord_pair|
  (coord_pair[0][0]<coord_pair[1][0] && coord_pair[0][1]>coord_pair[1][1]) || (coord_pair[0][0]<coord_pair[1][0] && coord_pair[0][1]>coord_pair[1][1])
}

diagonals=upwards_diagonals+downwards_diagonals

upwards_diagonals.each do |diag|
  x1=diag[0][0]<diag[1][0] ? diag[0][0] : diag[1][0]
  x2=diag[1][0]>diag[0][0] ? diag[1][0] : diag[0][0]
  y1=diag[0][1]<diag[1][1] ? diag[0][1] : diag[1][1]
  y2=diag[1][1]>diag[0][1] ? diag[1][1] : diag[0][1]
  horizontal_lines.each do |h_line|
    y=h_line[0][1]

    if y>=y1 && y<=y2
      x3=h_line[0][0]<h_line[1][0] ? h_line[0][0] : h_line[1][0]
      x4=h_line[1][0]>h_line[0][0] ? h_line[1][0] : h_line[0][0]

      x=y-y1+x1
      if x>=x1 && x<=x2 && x>=x3 && x<=x4
        crossing_points.add([x,y])
      end
    end
  end
  vertical_lines.each do |v_line|
    x=v_line[0][0]

    if x>=x1 && x<=x2
      y3=h_line[0][1]<h_line[1][1] ? h_line[0][1] : h_line[1][1]
      y4=h_line[1][1]>h_line[0][1] ? h_line[1][1] : h_line[0][1]
      y=x+y1-x1

      if y>=y1 && y<=y2 && y>=y3 && y<=y4
        crossing_points.add([x,y])
      end
    end
  end
end

downwards_diagonals.each do |diag|
  x1=diag[0][0]<diag[1][0] ? diag[0][0] : diag[1][0]
  x2=diag[1][0]>diag[0][0] ? diag[1][0] : diag[0][0]
  y1=diag[0][1]>diag[1][1] ? diag[0][1] : diag[1][1]
  y2=diag[1][1]<diag[0][1] ? diag[1][1] : diag[0][1]
  horizontal_lines.each do |h_line|
    y=h_line[0][1]

    if y>=y2 && y<=y1
      x3=h_line[0][0]<h_line[1][0] ? h_line[0][0] : h_line[1][0]
      x4=h_line[1][0]>h_line[0][0] ? h_line[1][0] : h_line[0][0]

      x=-y+y1+x1
      if x>=x1 && x<=x2 && x>=x3 && x<=x4
        crossing_points.add([x,y])
      end
    end
  end
  vertical_lines.each do |v_line|
    x=v_line[0][0]

    if x>=x1 && x<=x2
      y3=h_line[0][1]<h_line[1][1] ? h_line[0][1] : h_line[1][1]
      y4=h_line[1][1]>h_line[0][1] ? h_line[1][1] : h_line[0][1]
      y=-x+y1+x1

      if y>=y2 && y<=y1 && y>=y3 && y<=y4
        crossing_points.add([x,y])
      end
    end
  end
end

upwards_diagonals.each do |up_diag|
  x1=up_diag[0][0]<up_diag[1][0] ? up_diag[0][0] : up_diag[1][0]
  x2=up_diag[1][0]>up_diag[0][0] ? up_diag[1][0] : up_diag[0][0]
  y1=up_diag[0][1]<up_diag[1][1] ? up_diag[0][1] : up_diag[1][1]
  y2=up_diag[1][1]>up_diag[0][1] ? up_diag[1][1] : up_diag[0][1]

  downwards_diagonals.each do |down_diag|
    x3=down_diag[0][0]<down_diag[1][0] ? down_diag[0][0] : down_diag[1][0]
    x4=down_diag[1][0]>down_diag[0][0] ? down_diag[1][0] : down_diag[0][0]
    y3=down_diag[0][1]>down_diag[1][1] ? down_diag[0][1] : down_diag[1][1]
    y4=down_diag[1][1]<down_diag[0][1] ? down_diag[1][1] : down_diag[0][1]

    x=(x1+x3-y1+y3)/2
    y=(y1+y3-x1+x3)/2

    if (x1+x3-y1+y3)%2==0 && (y1+y3-x1+x3)%2==0 && x>=[x1,x3].max && x<=[x2,x4].min && y>=[y1, y4].max && y<=[y2,y3].min
      crossing_points.add([x,y])
    end
  end
end

upwards_diagonals.each do |up_diag1|
  upwards_diagonals.each do |up_diag2|
    x1=up_diag1[0][0]<up_diag1[1][0] ? up_diag1[0][0] : up_diag1[1][0]
    x2=up_diag1[1][0]>up_diag1[0][0] ? up_diag1[1][0] : up_diag1[0][0]
    y1=up_diag1[0][1]<up_diag1[1][1] ? up_diag1[0][1] : up_diag1[1][1]
    y2=up_diag1[1][1]>up_diag1[0][1] ? up_diag1[1][1] : up_diag1[0][1]
    x3=up_diag2[0][0]<up_diag2[1][0] ? up_diag2[0][0] : up_diag2[1][0]
    x4=up_diag2[1][0]>up_diag2[0][0] ? up_diag2[1][0] : up_diag2[0][0]
    y3=up_diag2[0][1]<up_diag2[1][1] ? up_diag2[0][1] : up_diag2[1][1]
    y4=up_diag2[1][1]>up_diag2[0][1] ? up_diag2[1][1] : up_diag2[0][1]

    if y3==x3+y1-x1 && up_diag1!=up_diag2
      (0..[x2,x4].min-[x1,x3].max).each do |k|
        crossing_points.add([[x1,x3].max+k], [y1,y3].max+k)
      end
    end
  end
end

downwards_diagonals.each do |down_diag1|
  downwards_diagonals.each do |down_diag2|
    x1=down_diag1[0][0]<down_diag1[1][0] ? down_diag1[0][0] : down_diag1[1][0]
    x2=down_diag1[1][0]>down_diag1[0][0] ? down_diag1[1][0] : down_diag1[0][0]
    y1=down_diag1[0][1]>down_diag1[1][1] ? down_diag1[0][1] : down_diag1[1][1]
    y2=down_diag1[1][1]<down_diag1[0][1] ? down_diag1[1][1] : down_diag1[0][1]
    x3=down_diag2[0][0]<down_diag2[1][0] ? down_diag2[0][0] : down_diag2[1][0]
    x4=down_diag2[1][0]>down_diag2[0][0] ? down_diag2[1][0] : down_diag2[0][0]
    y3=down_diag2[0][1]>down_diag2[1][1] ? down_diag2[0][1] : down_diag2[1][1]
    y4=down_diag2[1][1]<down_diag2[0][1] ? down_diag2[1][1] : down_diag2[0][1]

    if y3==-x3+y1+x1 && down_diag1!=down_diag2
      (0..[x2,x4].min-[x1,x3].max).each do |k|
        crossing_points.add([[x1,x3].max+k], [y1,y3].min+k)
      end
    end
  end
end

puts("The final answer is:")
puts(crossing_points.size)
