class AddColumnTokenToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :user_password, :string
  	add_column :users, :salt, :string
  	add_column :users, :key, :string
  	add_column :users, :secret_key, :string
  	add_column :users, :authentication_token, :string
  end
end
