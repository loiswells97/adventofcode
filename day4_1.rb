file_data = File.read("day4.txt").split

number_stream=file_data.shift.split(',')

puts(file_data[0])

arrays=(0...file_data.length).inject([]) do |arrays, index|

if index%25==0
  arrays<<[[file_data[index].to_i]]
elsif index%5==0
  arrays[index/25]<<[file_data[index].to_i]
else
  arrays[index/25][(index/5)%5]<<file_data[index].to_i
end
arrays
end

def play_bingo(number_stream, arrays)
  number_stream.each do |number|
    arrays=arrays.map do |grid|
      grid=grid.map do |row|
        # puts(row.sum)
        row=row.map do |x|
          if x==number.to_i
            -1
          else
            x
          end
        end
        row
      end
      grid
    end

    arrays.each do |grid|
      grid.each do |row|
        if row.sum==-5
          puts("BINGO")
          return [grid, number.to_i]
        end
      end
    end

    arrays.each do |grid|
      grid.transpose.each do |column|
        if column.sum==-5
          puts("BINGO")
          return [grid, number.to_i]
        end
      end
    end
  end
end

results=play_bingo(number_stream, arrays)

grid_values=results[0].flatten.map{|x| x<0 ? 0:x}

puts(grid_values)
puts(results[1])

puts(grid_values.sum*results[1])
