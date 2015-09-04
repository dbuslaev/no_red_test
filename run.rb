require 'rubygems'
require 'json'
require 'csv'

require_relative 'redquestion'

while true
  puts "Enter number of questions"
  total_questions = Integer(gets) rescue false 
  if total_questions and total_questions>0
    break
  else
    puts "Error: please enter a number great than 0"
  end
end

good_questions = RedQuestion.new('questions.csv', 'usage.csv').generate(total_questions)
good_questions.each do |row|
  puts "Question ID: #{row[:question_id]} Strand ID: #{row[:strand_id]} Standard ID: #{row[:standard_id]}"
end

puts "Done"
