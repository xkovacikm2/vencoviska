require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'obce.csv'))
csv = CSV.parse(csv_text, encoding: 'utf-8')

csv.each do |row|
  city = City.new
  city.name = row[1]
  city.save
end

color = AreaColor.new name:'red', description:'Zákaz vstupu so psom'
color.save

color = AreaColor.new name:'yellow', description: 'Vstup len na vodítku'
color.save

color = AreaColor.new name:'green', description:'Vstup bez obmedzení'
color.save

User.create!(name: 'hocikto19',
             email: 'xkovacikm2@gmail.com',
             password: '123456',
             password_confirmation: '123456',
             admin: true)