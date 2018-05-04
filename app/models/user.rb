class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable ,:validatable,
         :password_has_required_content, :password_disallows_frequent_reuse,
         :password_disallows_frequent_changes, :password_requires_regular_updates
 
  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  do_not_validate_attachment_file_type :image
  # validates_format_of :phone,
  #     :with => /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/,
  #     :message => "- Phone numbers must be in xxxxxxxxxx format."

end           