namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: "restaurant#{i.to_s}",
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "public//seed_img/#{rand(1..20)}.jpg"))
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.destroy_all
    #Default admin
    User.create(email: "rytg156@gmail.com", password: "12345678", name: "RT", role: "admin")
    puts "Default admin created!"

    20.times do |i|
      User.create!(email: FFaker::Name.first_name + "@mail.com", 
        password: "12345678")
    end
    User.each do |user|
      user.update(name: user.email.split('@').first)
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end
      #更精簡的假資料做法
      #20.times do |i|
        #user_name = FFaker::Name.first_name
        #User.create!(
          #name: user_name,
          #email: "#{user_name}@example.com",
          #password: "12345678"
        #)

  task fake_comment: :environment do
    Comment.destroy_all
      
    Restaurant.all.each do |restaurant|
      3.times do
          restaurant.create!(content: FFaker::Lorem.phrase,
          user: User.all.sample)
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end
end