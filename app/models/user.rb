class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :institute_name, :is_direct, :mobile_no, :max_tests, :is_admin, :has_paid, :is_guest, :uid, :provider, :oauth_token, :oauth_expires_at
  # attr_accessible :title, :body

  has_many :test_details
  has_many :test_results
  has_many :progress_report_users


  #def self.from_omniauth(auth)
  #  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #    user.provider = auth.provider
  #    user.uid = auth.uid
  #    user.name = auth.info.name
  #    user.email = auth.info.email
  #    user.oauth_token = auth.credentials.token
  #    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #    user.save!
  #  end
  #end

  after_create :send_registration_confirmation

  def send_registration_confirmation
    puts '====> ' + self.email
    #UserMailer.registration_confirmation(self).deliver
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts '==========>>>> ' + header.to_s
    (2..spreadsheet.last_row).each do |i|
      User.create(name: spreadsheet.row(i)[0], email: spreadsheet.row(i)[1], password: spreadsheet.row(i)[2], password_confirmation: spreadsheet.row(i)[2], mobile_no: spreadsheet.row(i)[3], max_tests: spreadsheet.row(i)[4], is_admin: false, is_direct: true, is_guest: false)
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
