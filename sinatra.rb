require "nokogiri"
require "sinatra"

get "/" do
  "Welcome to clesti"
end

NAME = 0
ROLE = 2

def collect_roles
  doc = Nokogiri::HTML(File.open("tmp/clesti.html"))

  all_roles = Hash.new(0)

  doc.css("tbody tr")[1..-1].each do |row|
    columns = row.css("td")

    name = columns[NAME].text.strip
    if name != ""
      # puts name
    end

    next unless columns[ROLE]
    role = columns[ROLE].text.strip
    all_roles[role] += 1
  end

  all_roles.sort.to_h.each do |role, count|
    puts "#{count}, #{role}"
  end
end
