class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable ,:validatable
  attr_accessor :password, :phone

  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
 # validate :password_complexity
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  do_not_validate_attachment_file_type :image
  validates :phone, :format => { :with => /\^\+[0-9]{1,3}\.[0-9]{4,14}(?:x.+)?$/, :message => "Not a valid 10-digit telephone number" }  
  # def password_complexity
  #   binding.pry
  #   if password.present? and not password.match(/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,20} /)
  #     errors.add :password, "must include at least one uppercase letter, and one special character"
  #   end
  # end
end           