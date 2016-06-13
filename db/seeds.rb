require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'obce.csv'))
csv = CSV.parse(csv_text, encoding: 'utf-8')

csv.each do |row|
  city = City.new
  city.name = row[1]
  city.save
end