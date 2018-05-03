class TodosController < ApplicationController
    before_action :authenticate_user!
	before_action :find_todo, :only => [:show,:edit, :update, :destroy]

	def index
    @todos = Todo.all
	end
   
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    respond_to do |format|
      if @todo.save
      	format.html{redirect_to todos_path, :notice => "Todo was successfully created"}
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
    respond_to do |format|
    	if @todo.update_attributes(todo_params)
    		format.html{redirect_to todos_path, :notice => "Todo was successfully updated."}
    		format.json {render :show, status: :created, location: @todo }
    	else
    		format.html {render :new}
    		format.json {render json:@todo.errors, status: :unprocessable_entity}
    	end
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path
  end

  private
  def todo_params
  	params.require(:todo).permit!
  end

  def find_todo
  	@todo = Todo.find(params[:id])
  end
end
