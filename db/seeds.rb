# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


100.times do
  User.create!(user_name: Faker::Internet.user_name)
end

User.all.each do |user|
  Poll.create!(title: Faker::Book.title, author_id: user.id)
end

Poll.all.each do |poll|
  Question.create!(question_text: Faker::Lorem.sentence, poll_id: poll.id)
end

Question.all.each do |question|
  AnswerChoice.create!(text: "A", question_id: question.id)
  AnswerChoice.create!(text: "B", question_id: question.id)
  AnswerChoice.create!(text: "C", question_id: question.id)
end

100.times do
  Response.create!(user_id: User.all.sample.id, answer_choice_id: AnswerChoice.all.sample.id)
end
