require_relative 'redcsv'

class Redquestion
include Redcsv

	def initialize(filename)
		read(filename) # read csv file
	end
	
	def generate(total_questions)
		csv_array=get()
		good_questions=[] # holds all questions on the output
		used_strands=[]
		used_standards=[]
		i=0
		while i < total_questions # loop collecting questions
			usable_questions=[]
			usable_strands_questions=[]
			csv_array.each do |row| # I am going to use numeric parameters, time preasure...
				if not used_strands.include? row[:strand_id]
		#	puts row[:strand_id]
					usable_strands_questions.push(row)
				end
			end
			if usable_strands_questions.length == 0 # go back to full list
				used_strands=[]
				usable_strands_questions=csv_array
			end
			usable_strands_questions.each do |row|
				if not used_standards.include? row[:standard_id] # check if standard was used
					usable_questions.push(row)
				end
			end
			if usable_questions.length == 0 # reset and run again, standard ids depleted
				used_strands=[]
				used_standards=[]
			else
				latest_usable_questions=[]
				usable_questions.each do |row|
					question_id=row[:question_id].to_s
#					if not usage_question_hash[question_id].nil?
#						if usage_question_hash[question_id][:assigned]!=true and usage_question_hash[question_id][:answered]!=true
#							latest_usable_questions.push(row)
#						end
#					else
						latest_usable_questions.push(row)
#					end
				end
				if latest_usable_questions.length == 0
					latest_usable_questions=usable_questions
				end
				id_to_use=Random.rand(0..(latest_usable_questions.length-1))
				to_use=latest_usable_questions[id_to_use]
				
				good_questions.push(to_use)
				used_strands.push(to_use[:strand_id]) # strand id
				used_standards.push(to_use[:standard_id]) # standard id
				question_id=to_use[:question_id].to_s
#				if usage_question_hash[question_id].nil?
#					usage_question_hash[question_id]={:answered=>false}
#				end
#				usage_question_hash[question_id][:assigned]=true;
				i+=1
			end
		end
		good_questions
	end
end