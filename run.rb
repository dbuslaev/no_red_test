require 'rubygems'
require 'json'
require 'csv'

require_relative 'redquestion'

#puts "Enter number of questions"
total_questions = 5#gets.to_i

good_questions = RedQuestion.new('questions.csv', 'usage.csv').generate(total_questions)
good_questions.each do |row|
  puts "Question ID: #{row[:question_id]} Strand ID: #{row[:strand_id]} Standard ID: #{row[:standard_id]}"
end

puts "Done"
