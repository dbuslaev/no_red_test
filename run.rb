require 'rubygems'
require 'json'
require 'csv'

puts "Enter number of questions"
total_questions=gets.to_i;

csv_text = File.read('questions.csv')
csv_array = JSON.parse(CSV.parse(csv_text).to_json) # reading into array

csv_ids=csv_array[0]
csv_array.shift()

csv_text = File.read('usage.csv')
usage_array = JSON.parse(CSV.parse(csv_text).to_json) # reading into array

usage_ids=usage_array[0]
usage_array.shift()

usage_question_hash={} # track usage by hash id for faster access
usage_array.each do |row|
	assigned_hours_ago= row[2].to_s.length>0 ? true : false
	answered_hours_ago= row[3].to_s.length>0 ? true : false
	usage_question_hash[row[1].to_s]={"assigned"=>assigned_hours_ago, "answered"=>answered_hours_ago}
#	puts usage_question_hash[row[1].to_s]["answered"].to_s
end

good_questions=[] # holds all questions on the output

used_strands=[]
used_standards=[]

i=0
while i < total_questions # loop collecting questions
	usable_questions=[]
	usable_strands_questions=[]
	csv_array.each do |row| # I am going to use numeric parameters, time preasure...
		if not used_strands.include? row[0]
			usable_strands_questions.push(row)
		end
	end
	if usable_strands_questions.length == 0 # go back to full list
		used_strands=[]
		usable_strands_questions=csv_array
	end
	usable_strands_questions.each do |row|
		if not used_standards.include? row[2] # check if standard was used
			usable_questions.push(row)
		end
	end
	if usable_questions.length == 0 # reset and run again, standard ids depleted
		used_strands=[]
		used_standards=[]
	else
		latest_usable_questions=[]
		usable_questions.each do |row|
			if not usage_question_hash[row[4].to_s].nil?
				if usage_question_hash[row[4].to_s]["assigned"]!=true and usage_question_hash[row[4].to_s]["answered"]!=true
					latest_usable_questions.push(row)
				end
			else
				latest_usable_questions.push(row)
			end
		end
		if latest_usable_questions.length == 0
			latest_usable_questions=usable_questions
		end
		id_to_use=Random.rand(0..(latest_usable_questions.length-1))
		to_use=latest_usable_questions[id_to_use]
		
		good_questions.push(to_use)
		used_strands.push(to_use[0]) # strand id
		used_standards.push(to_use[2]) # standard id
		if usage_question_hash[to_use[4].to_s].nil?
			usage_question_hash[to_use[4].to_s]={"answered"=>false}
		end
		usage_question_hash[to_use[4].to_s]["assigned"]=true;
		i+=1
	end
end


good_questions.each do |row|
	puts "Question ID: "+row[4]
end


puts "Done"
