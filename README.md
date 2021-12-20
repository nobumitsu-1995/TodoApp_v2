# TodoApp_v2について
本アプリケーションは、Ruby on Railsを学習した後に初めて1から作成したWebアプリです。Todoの追加、確認、編集、削除、完了等の操作ができる基本的なCRUDアプリになります。
<br><br>
以下の情報でログイン可能です。<br><br>
メールアドレス：hoge<br>
パスワード：hoge
<br>
- [アプリケーションURL](https://todo-deadline-management-app.herokuapp.com/todos)
<img width="1000" alt="top画像" src="./public/images/todo_top.png">

## 実装機能について
実装されている機能に関しては以下のようになっています。
- メールアドレス、パスワードを利用したログイン機能。
- ユーザーにアバターを設定する機能。
- Todoを追加、確認、編集、削除できる機能。
- Todoを完了、未完了にする機能。
- 進行中のTodo、締切なしのTodo、締切超過Todo、完了済みTodoの４つのテーブルに分けてTodoを表示する機能。
<br>

1. メールアドレス、パスワードを利用したログイン機能。<br>
![login](https://user-images.githubusercontent.com/70850598/146749409-7d7f5736-1663-42e3-8d64-5222fd573089.gif)
2. ユーザーにアバターを設定する機能。<br>
![edit_avatar](https://user-images.githubusercontent.com/70850598/146749720-f41d3b19-b061-40a0-8569-4f86e388d37c.gif)
3. Todoを追加、確認、編集、削除できる機能。<br>
Todoの個別情報表示ページはhelperを使うことで可読性が高くなるように意識しました。<br>
以下は一例ですが、複雑な時間の計算はhelperに書くことで、viewのコードを一行で済ませることができました。
```ruby:todos_helper.rb
def overdue_time_data(todo)
# 締め切りが設定されている場合は以下のコードが実行される
  if todo.deadline_time
    case
# Todoが締め切りを過ぎて完了している場合。
    when todo.completed? && todo.overdue_deadline?
      content_tag(:li, class: "list-group-item") do
        "超過時間：#{distance_of_time_in_words(todo.deadline_time, todo.end_time)}"
      end
# Todoが締め切りより早く完了している場合。
    when todo.completed? && !(todo.overdue_deadline?)
      content_tag(:li, class: "list-group-item") do
        "残り時間：#{distance_of_time_in_words(todo.deadline_time, todo.end_time)}"
      end
# Todoが進行中で締め切りが過ぎている場合。
    when !(todo.completed?) && todo.overdue_deadline?
      content_tag(:li, class: "list-group-item") do
        "超過時間：#{time_ago_in_words(todo.deadline_time)}"
      end
# Todoが進行中で締め切りがまだ過ぎていない場合。
    when !(todo.completed?) && !(todo.overdue_deadline?)
      content_tag(:li, class: "list-group-item") do
        "残り時間：#{time_ago_in_words(todo.deadline_time)}"
      end
    end
  end
end
```

```ruby:todos/show.html.erb
<%# viewのコードは一行で済む。%>
<%= overdue_time_data(@todo) %>
```

![crud_todo](https://user-images.githubusercontent.com/70850598/146749649-6fd9eee9-6bcc-44be-b6e9-f4df04544fab.gif)<br>
4. Todoを完了、未完了にする機能。<br>
Todoの「完了」「未完了」状態はenum型を使用して管理しました。
```ruby:models/todo.rb
enum status: {
  on_going: 0, # 進行中
  completed: 1 # 完了済み
}
```
![complete_todo](https://user-images.githubusercontent.com/70850598/146749501-d73c8d5e-d82d-41fd-bc6a-b3e565282e0c.gif)<br>
5. 進行中のTodo、締切なしのTodo、締切超過Todo、完了済みTodoの４つのテーブルに分けてTodoを表示する機能。<br>
scopeの機能をうまく活用し状態別のTodoを取得するようにしました。
```ruby:models/todo.rb 
scope :all_todos, -> (user) { where(user_id: user.id).order(:deadline_time) }   # ログイン中のユーザーの全てのTodo
scope :on_going_todos, -> { where(status: 0) }                                  # 進行中のTodo
scope :completed_todos, -> { where(status: 1) }                                 # 完了済みのTodo
scope :no_deadline, -> { where(deadline_time: nil) }                            # 締め切りが設定されていないTodo
scope :overdue_deadline, -> { where("deadline_time < ?", Time.zone.now) }       # 締め切りが過ぎているTodo
```

```ruby:todos/index.html.erb
<% @todos.on_going_todos.each do |todo| %>                    <% # 進行中のTodo %>
<% @todos.on_going_todos.no_deadline.each do |todo| %>        <% # 締切なしのTodo %>
<% @todos.on_going_todos.overdue_deadline.each do |todo| %>   <% # 締切超過Todo %>
<% @todos.completed_todos.each do |todo| %>                   <% # 完了済みTodo %>
```
![select_table](https://user-images.githubusercontent.com/70850598/146749582-04008429-bdd1-452c-992b-a363ef05c974.gif)

## データベース設計について
データベースの設計に関しては以下のER図の通りとなります。

<img width="490" alt="ER" src="./public/images/ER.png">

## 使用した技術スタック
JQuery, Ruby on Rails, PostgreSQL, Bootstrap, Heroku, AWS S3

## 使用している主なgemについて
- Rspec：　Railsの代表的なテストツールの一つ。単体テスト、統合テストを実行するために使用しました。
- Factory Bot：　テストのサンプルデータを簡単に作成することができるgem。
- enum_help：　Railsでenum型を使用するのを補助するgem。
- aws-sdk-s3：　ユーザーのアバター画像をS3に保存するためのgem。
