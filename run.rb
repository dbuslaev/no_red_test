require 'rubygems'
require 'json'
require 'csv'

total_questions=3;

csv_text = File.read('questions.csv')
csv_array = JSON.parse(CSV.parse(csv_text).to_json) # reading into array

csv_ids=csv_array[0]
csv_array.shift()
csv_array.each do |row|
	row.each do |column|
		puts column
	end
end

used_info={} # using hashes to track numeric counters for each strand

(0..(total_questions-1)).each do |i| # loop collecting questions
	puts "# #{i}"
end


puts "Done"
