class TodosController < ApplicationController
    before_action :authenticate_user!
	before_action :find_user, :only => [:new, :create, :index]
  before_action :find_todo, :only => [:show,:edit, :update, :destroy]

	def index
    if params[:type].present?
      @todos = @user.todos.order(:created_at => "#{params[:type]}")
    elsif params[:filter].present? and params[:filter] == "all"
      @todos = @user.todos.all
    elsif params[:filter].present? and params[:filter] == "completed"
      @todos = @user.todos.where(:status => "completed")
    elsif params[:filter].present? and params[:filter] == "upcoming"
      @todos = @user.todos.where("completion_time >?", Time.now)       
    else
      @todos = @user.todos.all
    end
	end
   
  def new
    @todo = @user.todos.build
  end

  def create
    @todo = @user.todos.build(todo_params)
    respond_to do |format|
      if @todo.save
      	format.html{redirect_to user_todos_path(:user_id => current_user.id), :notice => "Todo was successfully created"}
      	format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if params[:status].present?  and params[:manual_approve].present? and params[:manual_approve] == "true"
      @todo.perform_event(params[:status])
      redirect_to user_todos_path(:user_id => current_user.id)
    else 
      respond_to do |format|
      	if @todo.update_attributes(todo_params)
      		format.html{redirect_to user_todos_path(:user_id => current_user.id), :notice => "Todo was successfully updated."}
      		format.json {render :show, status: :created, location: @todo }
      	else
      		format.html {render :new}
      		format.json {render json:@todo.errors, status: :unprocessable_entity}
      	end
      end
    end
  end

  def destroy
    @todo.destroy
    redirect_to user_todos_path(:user_id => current_user.id)
  end

  private
  def todo_params
  	params.require(:todo).permit!
  end

  def find_user
  	@user = User.find(current_user.id)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end
end
