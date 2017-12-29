# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u=User.new
u.email="admin@email.com"
u.password="123456"
u.password_confirmation="123456"
u.is_admin=true
u.save

Category.create!(:name=>"文学")
Category.create!(:name=>"经济")
Category.create!(:name=>"社科")
Category.create!(:name=>"家庭")
Category.create!(:name=>"艺术")
Category.create!(:name=>"心理")
Category.create!(:name=>"商业")
