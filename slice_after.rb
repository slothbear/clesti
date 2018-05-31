require "nokogiri"

doc = Nokogiri::HTML File.read("tmp/clesti_micro.html")
table_rows = doc.css("tbody tr")
member_chunks = table_rows.slice_after {|tr| tr.at("hr")}
puts "#{member_chunks.count} members found."

member_chunks.each do |member|
  member.each do |role|
    next if role.at("hr")
    member_column,date,role = role.css("td")
    unless member_column.text.empty?
      member = member_column.text
      puts "\n-- #{member}"
    end

    puts "   #{date.text}, #{role.text}"
  end
end
