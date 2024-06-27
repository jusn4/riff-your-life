# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 puts "seedの実行を開始"
  User.find_or_create_by!(email: "test@test") do |user|
    user.name = "タカマサ"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon.png"), filename:"sample-user1.jpg")
  end
  
  User.find_or_create_by!(email: "test2@test") do |user|
    user.name = "yuki"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon2.png"), filename:"sample-user2jpg")
  end
  
  User.find_or_create_by!(email: "test3@test") do |user|
    user.name = "ゆきひろ"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon3.png"), filename:"sample-user3.jpg")
  end
  
  User.find_or_create_by!(email: "test4@test") do |user|
    user.name = "James"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon4.png"), filename:"sample-user4.jpg")
  end
  
  User.find_or_create_by!(email: "test5@test") do |user|
    user.name = "タナカ"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon5.png"), filename:"sample-user5.jpg")
  end
  
  User.find_or_create_by!(email: "test6@test") do |user|
    user.name = "ふとし"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon6.png"), filename:"sample-user6.jpg")
  end
  
  User.find_or_create_by!(email: "test7@test") do |user|
    user.name = "ユウシ"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon7.png"), filename:"sample-user7.jpg")
  end
  
  User.find_or_create_by!(email: "test8@test") do |user|
    user.name = "Adam"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon8.png"), filename:"sample-user8.jpg")
  end
  
  User.find_or_create_by!(email: "test9@test") do |user|
    user.name = "雪印"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon9.png"), filename:"sample-user9.jpg")
  end
  
  User.find_or_create_by!(email: "test10@test") do |user|
    user.name = "ゆきだるま"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon10.png"), filename:"sample-user10.jpg")
  end
  
  User.find_or_create_by!(email: "test11@test") do |user|
    user.name = "浅草"
    user.password = "password"
    user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/icon11.png"), filename:"sample-user11.jpg")
  end
  
  Admin.find_or_create_by!(email:ENV['ADMIN_EMAIL'] ) do |admin|
    admin.password = ENV['ADMIN_PASSWORD']
  end

puts "seedの実行が完了しました"