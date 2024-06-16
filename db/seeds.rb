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

#Admin.find_or_create_by!(email: "admin@admin.com",password: 'example')
Admin.find_or_create_by!(email:ENV['ADMIN_EMAIL'] ) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

puts "seedの実行が完了しました"