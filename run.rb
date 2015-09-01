require 'rubygems'
require 'json'
require 'csv'

csv_text = File.read('questions.csv')
csv_array = JSON.parse(CSV.parse(csv_text).to_json)

csv_array.each do |row|
	row.each do |column|
		puts column
	end
end

puts "Done"
