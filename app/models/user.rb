class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :institute_name, :is_direct, :mobile_no, :max_tests, :is_admin, :is_guest, :uid, :provider, :oauth_token, :oauth_expires_at
  # attr_accessible :title, :body

  has_many :test_details
  has_many :test_results


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

end
