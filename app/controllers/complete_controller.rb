class CompleteController < ApplicationController
  before_action :set_todo
  def create
    Todo.set_status(@todo)
    @todo.save
    redirect_to @todo, notice: "Todoを完了しました。"
  end

  def destroy
    Todo.set_status(@todo)
    @todo.save
    redirect_to @todo, notice: "Todoを未完了に戻しました。"
  end

  private

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end
end
