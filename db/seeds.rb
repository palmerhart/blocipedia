include Faker

10.times do
    user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    confirmed_at: Time.now
    )
end

admin = User.create!(
email: 'palmerhart@gmail.com',
password: 'password',
role: 'admin',
confirmed_at: Time.now
)

users = User.all

20.times do
    Wiki.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user: users.sample
        )
    end
        
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."