require 'faker'

1.times do
   pw = Faker::Internet.password

   User.create!(
      email: Faker::Internet.email,
      password: pw,
      password_confirmation: pw
   )
end
users = User.all

1.times do
   Wiki.create!(
      title: Faker::HarryPotter.book,
      body: Faker::HarryPotter.quote,
      user: users.sample
   )
end
wikis = Wiki.all

puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
