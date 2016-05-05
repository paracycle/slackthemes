file = File.open('../data/themes.yml')
arr = []
file.each_line{|l| arr << l}
arr.sort_by!{|l| l[85..-1]}
file.close

File.open("../data/themes.yml", "w") do |f|
  f.puts(arr)
end
