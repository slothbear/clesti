require "nokogiri"

NAME = 0
ROLE = 2

doc = Nokogiri::HTML(File.open("clesti.html"))

doc.css("tbody tr")[1..-1].each do |row|
  columns = row.css("td")

  name = columns[NAME].text.strip
  if name != ""
    puts name
  end

  if columns[ROLE]
    role = columns[ROLE].text.strip
    puts "   #{role}"
  end

end

__END__
