class Todo < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 200}, presence: true
  validates :start_time, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  enum status: {
    on_going: 0,
    completed: 1
  }
  scope :all_todos, -> (user) { where(user_id: user.id).order(:deadline_time) }
  scope :on_going_todos, -> { where(status: 0) }
  scope :completed_todos, -> { where(status: 1) }
  scope :no_deadline, -> { where(deadline_time: nil) }
  scope :overdue_deadline, -> { where("deadline_time < ?", Time.zone.now) }

  def self.set_status(todo)
    case todo.status
    when nil
      todo.start_time = Time.zone.now
      todo.status = 'on_going'
    when "on_going"
      todo.end_time = Time.zone.now
      todo.status = 'completed'
    when "completed"
      todo.end_time = nil
      todo.status = 'on_going'
    end
  end

  def overdue_deadline?
    return true if deadline_time && deadline_time < Time.zone.now
  end

end
