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
#		puts column
	end
end

used_info={} # using hashes to track numeric counters for each strand

used_strands=[]
used_standards=[]
used_questions=[]
i=0
while i < total_questions # loop collecting questions
	usable_questions=[]
	csv_array.each do |row| # I am going to use numeric parameters, time preasure...
		if not used_strands.include? row[0]
			usable_questions.push(row)
		end
	end
	if usable_questions.length>0 # if something was found that has not been used
		i+=1
	else # no matches, get anything
		used_strands=[]
		used_standards=[]
		used_questions=[]
	end
#	usable_questions.each do |row|
#		puts row[0]
#	end
end


puts "Done"
