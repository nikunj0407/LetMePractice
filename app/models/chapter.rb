class Chapter < ActiveRecord::Base
  attr_accessible :name, :weightage
  has_many :questions

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts '==========>>>> ' + header.to_s
    (2..spreadsheet.last_row).each do |i|
      Chapter.create(name: spreadsheet.row(i)[0], weightage: spreadsheet.row(i)[1])
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
