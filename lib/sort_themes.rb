filename = 'data/themes.yml'
file = File.open(filename)
arr = []
file.each_line{|l| arr << l}
arr.sort_by!{|l| l[85..-1]}
file.close

File.open(filename, "w") do |f|
  f.puts(arr)
end
