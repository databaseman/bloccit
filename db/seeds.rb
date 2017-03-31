# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Unique Posts
# Post.find_or_create_by(
#  title:  'This is a unique Title',
#  body:   'This is a unique paragraph'
# )

Vote.delete_all;
Comment.delete_all;
Post.delete_all;
Topic.delete_all;
User.delete_all;

#5.times do |n|
#  name = "user-#{n+1}_"+RandomData.random_name
#  email = "user-#{n+1}_"+RandomData.random_email
#  User.create!(
#    name:     name,
#    email:    email,
#    password: "password"
#  )
#end

5.times do |n|
  name = "user#{n+1}"
  email = "user#{n+1}@yahoo.com"
  User.create!(
    name:     name,
    email:    email,
    password: "password"
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'a@yahoo.com',
  password: 'admin_password',
  role:     'admin'
)
users = User.all

# Create Topics
10.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
25.times do
  post = Post.create!(
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
  post.update_attribute(:created_at, rand(10.minutes..1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end

posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end


puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
