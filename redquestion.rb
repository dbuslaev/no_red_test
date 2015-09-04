require_relative 'redcsv'
require_relative 'redusage'

class RedQuestion
include RedCsv

  @usage_filename='' # holds usage file name

  def initialize(question_filename, usage_filename)
    read(question_filename) # read csv file
    @usage_filename=usage_filename # save usage filename
  end
  
  def generate(total_questions) # generate set of questions
    usage_question_hash=RedUsage.new(@usage_filename).question_hash() # usage by question_id

    all_questions = get() # all questions data

    good_questions = [] # holds all questions on the output
    used_strands = [] # tracks repeat usage
    used_standards = [] # tracks repeat usage
    i = 0
    while true # loop collecting questions
      usable_questions = []
      usable_strands_questions = []
      all_questions.each do |row|
        unless used_strands.include? row[:strand_id]
          usable_strands_questions.push(row)
        end
      end
      if usable_strands_questions.length == 0 # go back to full list
        used_strands = []
        usable_strands_questions = all_questions
      end
      usable_strands_questions.each do |row|
        unless used_standards.include? row[:standard_id] # check if standard was used
          usable_questions.push(row)
        end
      end
      if usable_questions.length == 0 # reset and run again, standard ids depleted
        used_strands = []
        used_standards = []
      else
        unique_questions = []
        usable_questions.each do |row|
          question_id = row[:question_id].to_s
          if usage_question_hash[question_id].nil?
            unique_questions.push(row)
          else
            if usage_question_hash[question_id][:assigned] != true and usage_question_hash[question_id][:answered] != true
              unique_questions.push(row)
            end
          end
        end
        if unique_questions.length == 0
          unique_questions = usable_questions
        end
        id_to_use = Random.rand(0..(unique_questions.length-1))
        use_question = unique_questions[id_to_use]
        
        good_questions.push(use_question)
        used_strands.push(use_question[:strand_id]) # strand id
        used_standards.push(use_question[:standard_id]) # standard id
        question_id = use_question[:question_id].to_s
        if usage_question_hash[question_id].nil?
          usage_question_hash[question_id] = {
            :answered => false
          }
        end
        usage_question_hash[question_id][:assigned] = true
        i += 1
        if i >= total_questions
          break
        end
      end
    end
    good_questions
  end
end