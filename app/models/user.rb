class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :password , :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/, message: "must be at least 8 characters and include one number and one letter."}
  validates :username, :phone, :presence => true
  validates_format_of :phone, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
  validates :phone, :numericality => true, :length => { :minimum => 10, :maximum => 11 }

  before_save :encrypt_password
  after_save :clear_password
  has_many :todos, :dependent => :destroy
  def image_url(style=:thumb)
    style.present? ? self.image.url(style) : self.image.url
  end

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end
end