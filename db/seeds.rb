# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Unique Questions
10.times do
  Question.find_or_create_by!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph,
    resolved:  false
  )
end

# Create Unique Posts
Post.find_or_create_by(
  title:  'This is a unique Title',
  body:   'This is a unique paragraph'
)

# Create Posts
50.times do
  Post.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts 'Seed finished'
puts "#{Question.count} questions created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
