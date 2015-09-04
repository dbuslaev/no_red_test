require 'rubygems'
require 'json'
require 'csv'

require_relative 'redquestion'

questions=Redquestion.new('questions.csv')

#usages=Redquestion.new('usage.csv')
#puts usages.get()

#puts "Enter number of questions"
total_questions=5#gets.to_i;

csv_text = File.read('usage.csv')
usage_array = JSON.parse(CSV.parse(csv_text).to_json) # reading into array

usage_array.shift()

usage_question_hash={} # track usage by hash id for faster access
usage_array.each do |row|
	assigned_hours_ago= row[2].to_s.length>0 ? true : false
	answered_hours_ago= row[3].to_s.length>0 ? true : false
	usage_question_hash[row[1].to_s]={:assigned=>assigned_hours_ago, :answered=>answered_hours_ago}
end




good_questions=questions.generate(total_questions)
good_questions.each do |row|
	puts "Question ID: #{row[:question_id]} Strand ID: #{row[:strand_id]} Standard ID: #{row[:standard_id]}"
end

puts "Done"
