require "nokogiri"
require "pry-byebug"

NAME = 0
ROLE = 2

roles_max = [3, 2, 3, 2, 3, 1, 2, 2, 0, 2]


def collect_roles(html)
  doc = Nokogiri::HTML(html)

  all_roles = Hash.new(0)

  doc.css("tbody tr")[1..-1].each do |row|
    columns = row.css("td")
    next unless columns[ROLE]

    name = columns[NAME].text.strip
    role = columns[ROLE].text.strip
    all_roles[role] += 1
  end

  result = Array.new
  all_roles.sort.to_h.each do |role, count|
    # result << "#{count}, #{role}"
    result << "#{role}"
  end
  result
end

def count_roles(html)
  doc = Nokogiri::HTML(html)
  member = ""
  project_options = YAML.load(DATA.read)

  doc.css("tbody tr")[1..-1].each do |row|
    columns = row.css("td")
    next unless columns[ROLE]

    member_column = columns[NAME].text.strip
    if !member_column.to_s.empty?
      # report on current member
      member = member_column # new member!
      roles_completed = []
      DATA.rewind
      project_options = YAML.load(DATA.read)
    end

    role_raw = columns[ROLE].text.strip
    role = role_raw.split("#").first

    puts project_options
    next unless project_options.key?(role)

    puts "#{member}   #{role}"
  end
end

#puts collect_roles(File.read("tmp/clesti.html"))

count_roles(File.read("tmp/clesti.html"))




__END__
Ah-Counter: [1]
Evaluation Speech Contestant: [5, 4]
Evaluator: [3, 2, 1, 8]
General Evaluator: [3, 10, 8, 2, 7, 5]
Grammarian / Wordmaster: [3, 2, 1, 4]
Humorous Speech Contestant: [5, 4]
International Speech Contestant: [5, 4]
Speaker: [5, 4]
Table Topics Speech Contestant: [5, 4]
Timer: [1]
Toastmaster: [10, 7, 8, 5, 4]
Topicsmaster: [4, 7, 5]
