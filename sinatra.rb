require "nokogiri"
require "sinatra"

get "/" do
  haml :home
end

post "/" do
  begin
    haml collect_roles(params['rolehtml'])
  rescue
    "apologies, but we encountered an error with your html: #{$!}<br>#{caller.first(2)}"
  end

end

NAME = 0
ROLE = 2

def collect_roles(html)
  doc = Nokogiri::HTML(html)

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

  result = Array.new
  all_roles.sort.to_h.each do |role, count|
    result << [count, role]
  end
  result
end
