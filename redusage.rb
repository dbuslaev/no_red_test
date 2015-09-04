require_relative 'redcsv'

class RedUsage
include RedCsv

  def initialize(filename)
    read(filename) # read csv file
  end
  
  def question_hash() # returns data hash by question_id
    usage_array=get()
    usage_question_hash = {} # track usage by hash id for faster access
    usage_array.each do |row|
      assigned_hours_ago= row[:assigned_hours_ago].to_s.length > 0 ? true : false
      answered_hours_ago= row[:answered_hours_ago].to_s.length > 0 ? true : false
      usage_question_hash[row[:question_id].to_s] = {
        :assigned => assigned_hours_ago,
        :answered => answered_hours_ago
      }
    end
    usage_question_hash
  end
end