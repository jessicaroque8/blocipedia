require 'faker'

3.times do
   pw = Faker::Internet.password

   User.create!(
      email: Faker::Internet.email,
      password: pw,
      password_confirmation: pw
   )
end

1.times do
   pw = 'helloworld'

   User.create!(
      email: 'test@email.com',
      password: 'helloworld',
      password_confirmation: 'helloworld'
   )
end
users = User.all

5.times do
   Wiki.create!(
      title: Faker::HarryPotter.book,
      body: Faker::HarryPotter.quote,
   )
end
wikis = Wiki.all

wikis.each do |w|
   owner = Collaborator.new(wiki_id: w.id, user_id: users.sample.id, owner: true)
   owner.save
end
owners = Collaborator.where(owner: true)

puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
puts "#{owners.count} collaborators (owners) of wikis created"
