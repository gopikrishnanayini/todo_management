class Api::V4::UsersController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token  
  before_action :set_instances_for_get_key, :check_user_presence_for_get_key, :only => [:log_in]

  def log_in
    if @user.present? and not (@user.encrypted_password == BCrypt::Engine.hash_secret(@password, @user.salt))
      render :status=>200, :json=>{:status=>"Failure",:message=>"Invalid password."} and return
    else
      if @user.present?
        @user.save
        render :staus => 200, :json => {:status => "Success",:users => @user.as_json(:except => [:image_file_name,:image_content_type,:image_file_size,:image_updated_at], :methods => [:image_url]) ,:todos => @user.todos.as_json(:except => [:image_file_name,:image_content_type,:image_file_size,:image_updated_at], :methods => [:image_url]) } rescue []
      else
        render :status => 200, :json => {:status => "Failure", :message => "Todo Not Found."}
      end 
    end
  end

  def set_instances_for_get_key
    @user = User.find_by_email(params[:email].downcase) rescue nil 
  end

  def check_user_presence_for_get_key
    @email, @password = params[:email], params[:password]
    if @email.blank? or @password.blank?
      if request.format == :json
        render :status=>200,:json=>{:status=>"Failure",:message=>"The request must contain the email and password."} and return
      else
        @status = 'Invalid Username or Password' and return
      end
    end
    if @user.nil?
      logger.info("User #{@email} failed signin, user cannot be found.")
      if request.format == :json
        render :status=>200, :json=>{:status=>"Failure",:message=>"Invalid email"} and return
      else
        @status = 'Invalid Username or Password'
      end
    end
  end
end
