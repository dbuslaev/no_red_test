module Redcsv

  @data = {}

  def read(filename) # read dataset from the file
    csv_text = File.read(filename)

    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    csv = CSV.new(csv_text, :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])
    @data = csv.to_a.map{ |row| row.to_hash }
  end

  def get() # return saved dataset
    @data
  end
end