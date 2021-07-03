module TodosHelper
  def deadline_time_data(todo)
    if todo.deadline_time
      content_tag(:li, class: "list-group-item") do
        "締切時間：#{l(todo.deadline_time)}"
      end
    end
  end

  def end_time_data(todo)
    if todo.end_time
      content_tag(:li, class: "list-group-item") do
        "終了時間：#{l(todo.end_time)}"
      end
    end
  end

  def working_time_data(todo)
    if todo.completed?
      content_tag(:li, class: "list-group-item") do
        "作業時間：#{distance_of_time_in_words(todo.start_time, todo.end_time)  }"
      end
    else
      content_tag(:li, class: "list-group-item") do
        "作業時間：#{time_ago_in_words(todo.start_time)}"
      end
    end
  end

  def overdue_time_data(todo)
    if todo.deadline_time
      case
      when todo.completed? && todo.overdue_deadline?
        content_tag(:li, class: "list-group-item") do
          "超過時間：#{distance_of_time_in_words(todo.deadline_time, todo.end_time)}"
        end
      when todo.completed? && !(todo.overdue_deadline?)
        content_tag(:li, class: "list-group-item") do
          "残り時間：#{distance_of_time_in_words(todo.deadline_time, todo.end_time)}"
        end
      when !(todo.completed?) && todo.overdue_deadline?
        content_tag(:li, class: "list-group-item") do
          "超過時間：#{time_ago_in_words(todo.deadline_time)}"
        end
      when !(todo.completed?) && !(todo.overdue_deadline?)
        content_tag(:li, class: "list-group-item") do
          "残り時間：#{time_ago_in_words(todo.deadline_time)}"
        end
      end
    end
  end
  
  def complete_link(todo)
    if todo.completed?
      link_to "未完了に戻す", todo_complete_path(@todo, 1), method: :delete, data: {confirm: "Todoを未完了に戻します。"}
    else
      link_to "完了", todo_complete_index_path(@todo), method: :post, data: {confirm: "Todoを完了します。"}
    end
  end
end
