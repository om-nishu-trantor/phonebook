f = File.new("newfile",  "w+")
PhoneList.pluck(:name, :phone).map do |a|
  f<<"#{a.first} - #{a.last} \n"
end
f.close