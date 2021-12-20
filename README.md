# TodoApp_v2について
本アプリケーションは、Ruby on Railsを学習した後に初めて1から作成したWebアプリです。Todoの追加、確認、編集、削除、完了等の操作ができる基本的なCRUDアプリになります。
<br><br>
以下の情報でログイン可能です。<br><br>
メールアドレス：hoge<br>
パスワード：hoge
<br>
- [アプリケーションURL](https://todo-deadline-management-app.herokuapp.com/todos)
<img width="1000" alt="top画像" src="./public/images/todo_top.png">

## 実装機能、工夫点について
実装されている機能、工夫点に関しては以下のようになっています。
- メールアドレス、パスワードを利用したログイン機能。
- ユーザーにアバターを設定する機能。
- Todoを追加、確認、編集、削除できる機能。
- Todoを完了、未完了にする機能。
- 進行中のTodo、締切なしのTodo、締切超過Todo、完了済みTodoの４つのテーブルに分けてTodoを表示する機能。
<br>

1. メールアドレス、パスワードを利用したログイン機能

2. ユーザーにアバターを設定する機能
3. Todoを追加、確認、編集、削除できる機能。
4. Todoを完了、未完了にする機能。
5. 進行中のTodo、締切なしのTodo、締切超過Todo、完了済みTodoの４つのテーブルに分けてTodoを表示する機能。
Todoはenumで状態管理されており、完了処理することで、完了済みTodoになります。
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
