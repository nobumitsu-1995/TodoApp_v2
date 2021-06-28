class Todo < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 200}, presence: true
  validates :start_time, presence: true
  enum status: {
    on_going: 0,
    completed: 1
  }

  def self.set_status(todo)
    case todo.status
    when nil
      todo.status = "on_going"
      todo.start_time = Time.zone.now
    when "on_going"
      todo.status = "completed"
    when "completed"
      todo.status = "on_going"
    end
  end

end
