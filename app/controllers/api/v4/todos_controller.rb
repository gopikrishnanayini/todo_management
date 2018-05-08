class Api::V4::TodosController < ApplicationController
  respond_to :json
  
  def index
	  todos = Todo.all rescue []
	  if todos.present?
	    render :staus => 200, :json => {:status => "Success",:todos => todos.as_json(:except => [:image_file_name,:image_content_type,:image_file_size,:image_updated_at], :methods => [:image_url]) } rescue []
	  else
	    render :status => 200, :json => {:status => "Failure", :message => "Todo Not Found."}
	  end 
  end
end
