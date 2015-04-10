class TodosController < ApplicationController
  def index
    @todo_items =  Todo.all # fetches all the rows of Todo model and stores it to @todo items array
     #render :delete  # shows the delete html page in the index url
     render :index, :layout => true
  end
  def delete
    @todo_new = Todo.last
    @todo_new.delete
  end
  def add
	todo = Todo.create(:todo_item => params[:todo_text])
	unless todo.valid?
	    flash[:error] = todo.errors.full_messages.join("<br>").html_safe
	 else
            flash[:success] = "Todo added successfully"   
	end
	redirect_to :action => "index"
  end
  
  def complete
   params[:todos_checkbox].each do |check|
     todo_id = check
     t = Todo.find_by_id(todo_id)
     t.update_attribute(:completed, true)
   end
   redirect_to :action => 'index'
  end

private

  def person_params
    params.require(:Todo).permit(:todo_item, :completed)
  end
  
end
