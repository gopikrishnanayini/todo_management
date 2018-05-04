# frozen_string_literal: true

Devise.setup do |config|
  #The number of uppercase letters (latin A-Z) required in a password:
  config.password_required_uppercase_count = 1

  #The number of special characters (!@#$%^&*()_+-=[]{}|') required in a password:
  config.password_required_special_character_count = 1

end
