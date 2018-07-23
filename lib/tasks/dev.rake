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
      user_name = FFaker::Name.first_name
      User.create!(
        name: user_name,
        email: "#{user_name}@example.com",
        password: "12345678"
        )
    end
      
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end
      #舊的做法一些細節當作往後參考
      #20.times do |i|
        #User.create!(email: FFaker::Name.first_name + "@mail.com", 
        #password: "12345678")
      #end
      #User.each do |user|
        #user.update(name: user.email.split('@').first)
      #end

  task fake_comment: :environment do
    Comment.destroy_all
      
    Restaurant.all.each do |restaurant|
      3.times do
          restaurant.comments.create!(content: FFaker::Lorem.phrase,
          user: User.all.sample)
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all

    User.all.each do |user|
      25.times do
        user.favorites.create!(
        restaurant: Restaurant.all.sample,
        )
      end
    end
    puts "have created fake favorite"
    puts "now you have #{Favorite.count} favorited restaurants"
  end

  task fake_like: :environment do
    Like.destroy_all

    User.all.each do |user|
      25.times do
        user.likes.create!(
        restaurant: Restaurant.all.sample,
        )
      end
    end
    puts "have created fake like"
    puts "now you have #{Like.count} liked restaurants"
  end

  task fake_followship: :environment do
    Followship.destroy_all

    User.all.each do |user|
      @users = User.where.not(id: user.id).shuffle
      10.times do
        user.followships.create!(
        following: @users.pop,
        )
      end
    end
    puts "have created fake followship"
    puts "now you have #{Followship.count} followship"
  end

  #fake all data
  task fake_all do
    #Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_restaurant'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_comment'].execute
    Rake::Task['dev:fake_favorite'].execute
    Rake::Task['dev:fake_like'].execute
    Rake::Task['dev:fake_followship'].execute
  end

end