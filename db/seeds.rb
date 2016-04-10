User.create!(name:  "Example User",
             email: "example@example.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

10.times do |n|
  City.create! name: "city n.#{n+1}"
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.org"
  description = Faker::Lorem.sentence(20)
  password = "password"
  city_id = (n%10)+1
  User.create!(name:  name,
               email: email,
               description: description,
               password:              password,
               password_confirmation: password,
               city_id: city_id,
               birthday: Time.at(rand * (100.years.ago.to_f - Time.now.to_f)))
end

City.order(name: :asc).take(10).each do |city|
  32.times do |n|
    id= n+1
    city.areas.create! name: "zona #{n+1}", user_id: id
  end
end

users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.comments.create! content: content, area_id: n+1
  end
end

Area.all.each_with_index do |area, index|
  (index%5).times do |i|
    area.area_border_lines.create! area_id: area.id
  end
end