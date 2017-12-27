require 'random_data'

5.times do
   User.create!(
      email: RandomData.random_email,
      password: 'valid_password',
      password_confirmation: 'valid_password'
   )
end
users = User.all

10.times do
   Wiki.create!(
      title: RandomData.random_name,
      body: RandomData.random_paragraph,
      user: users.sample
   )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
