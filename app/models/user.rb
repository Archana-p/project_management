class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name , :uid,:provider ,:oauth_token,:oauth_expires_at ,:image ,:profile_pic
  # attr_accessible :title, :body
  has_and_belongs_to_many :projects
  has_many :owned_projects,:class_name => "Project" ,foreign_key: :admin_id
  has_many :tasks 
  has_many :authentications
  mount_uploader :profile_pic, ImageUploader

  def self.from_omniauth(auth)
    
     user = User.find_by_email(auth["info"]["email"])
     #binding.pry
     authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     #binding.pry
     if authentication.present?
        user = authentication.user
      end
     if user.present? 
      user.update_attributes(image:auth["info"]["image"] )
     else
      user=User.new(email: auth["info"]["email"].to_s,name:auth["info"]["name"],password:auth["info"]["password"],password_confirmation:auth["info"]["password_confirmation"],image:auth["info"]["image"])
      user.save(validate: false)
     end
     user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
     user
=begin
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = auth.password
      #user.password_confirmation = auth.info.password_confirmation
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
=end

  end

end
