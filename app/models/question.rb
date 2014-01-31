class Question < ActiveRecord::Base
  attr_accessible :chapter_id, :cipher, :img, :type, :weightage
  has_attached_file :img

  belongs_to :chapter
  has_many :options
  has_many :test_details

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts '==========>>>> ' + header.to_s
    (2..spreadsheet.last_row).each do |i|
      puts '=========> ' + spreadsheet.row(i).to_s
      puts '=========> ' + spreadsheet.row(i)[0].to_s
      puts '=========> ' + spreadsheet.row(i)[4].to_s
      options_array = spreadsheet.row(i)[4].split('||');
      puts '=========> ' + options_array.to_s
      question = Question.create(chapter_id: Chapter.where(name: spreadsheet.row(i)[0]).first.id, cipher: spreadsheet.row(i)[1], type: spreadsheet.row(i)[2], weightage: spreadsheet.row(i)[3])
      options_array.each_with_index do |opt, index|
        if(spreadsheet.row(i)[2] != 'ShortNote')
          question.options.create(key: opt.split(':')[0], val: opt.split(':')[1])
        else
          question.options.create(key: opt, val: spreadsheet.row(i)[3])
        end
      end
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
