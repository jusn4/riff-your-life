User.create!(
  email: 'test@test.com',
  name: 'タカマサ',
  password: 'example'
  )
  
#Admin.find_or_create_by!(email: "admin@admin.com",password: 'example')
Admin.find_or_create_by!(email: 'admin@admin.com') do |admin|
  admin.password = 'example'
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
