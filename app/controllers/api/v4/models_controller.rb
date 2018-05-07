class Api::V4::ModelsController < ApplicationController
  before_action :authenticate_model,  only: [:index, :current, :update]

  def index
    render json: {status: 200, msg: 'Logged-in'}
  end
  
  def current
    current_model.update!(last_sign_in_at: Time.now)
    render json: current_model
  end

  def create
	  model = Model.new(model_params)
	  if model.save
	    render json: {status: 200, msg: 'User was created.'}
	  end
  end

	def update
	  model = Model.find(params[:id])
	  if model.update(model_params)
	    render json: { status: 200, msg: 'User details have been updated.' }
	  end
	end

	def destroy
	  model = Model.find(params[:id])
	  if model.destroy
	    render json: { status: 200, msg: 'User has been deleted.' }
	  end
	end

  private
  def user_params
    params.require(:model).permit(:username, :email, :password, :password_confirmation)
  end
end
