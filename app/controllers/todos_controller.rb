class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  def index
    todos = Todo.all_todos(@current_user)
    @on_going_todos = todos.on_going_todos
    @no_deadline_todos = @on_going_todos.no_deadline
    @overdue_deadline_todos = @on_going_todos.overdue_deadline
    @completed_todos = todos.completed_todos
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = current_user.todos.build(todo_params)
    Todo.set_status(@todo)
    if @todo.save
      redirect_to todos_path, notice: "作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notoce: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "削除しました。"
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:content, :deadline_time)
  end
end
