require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "validationチェック" do
    context "有効な条件" do
      it ":content, :start_time, :status, :user_idがあれば有効なこと" do
        expect(FactoryBot.create(:todo)).to be_valid
      end

      it ":contentの文字数が200文字の場合有効であること" do
        todo =  FactoryBot.build(:todo, content: "a" * 200)
        todo.valid?
        expect(todo.errors[:content]).to be_empty
      end
    end
    context "無効な条件" do
      it ":contentがなければ無効な状態であること" do
        todo =  FactoryBot.build(:todo, content: nil)
        todo.valid?
        expect(todo.errors[:content]).to include("を入力してください")
      end
      it ":start_timeがなければ無効な状態であること" do
        todo =  FactoryBot.build(:todo, start_time: nil)
        todo.valid?
        expect(todo.errors[:start_time]).to include("を入力してください")
      end
      it ":statusがなければ無効な状態であること" do
        todo =  FactoryBot.build(:todo, status: nil)
        todo.valid?
        expect(todo.errors[:status]).to include("を入力してください")
      end
      it ":user_idがなければ無効な状態であること" do
        todo =  FactoryBot.build(:todo, user_id: nil)
        todo.valid?
        expect(todo.errors[:user_id]).to include("を入力してください")
      end
      it ":contentの文字数が201文字の場合無効な状態であること" do
        todo =  FactoryBot.build(:todo, content: "a" * 201)
        todo.valid?
        expect(todo.errors[:content]).to include("は200文字以内で入力してください")
      end
    end
  end

  describe "set_todo_statusの動作" do
    it ":status未設定の場合、on_goingを返し:start_timeを設定する" do
      todo =  FactoryBot.create(:todo)
      todo.status = nil
      todo.start_time = nil
      Todo.set_status(todo)
      expect(todo.on_going? && todo.start_time).to be_truthy
    end
    it "既にon_goingの場合、completedに更新する" do
      todo =  FactoryBot.create(:todo, status: 0)
      Todo.set_status(todo)
      expect(todo.status).to eq("completed")
    end
    it "既にcompletedの場合、on_goingに変更する" do
      todo =  FactoryBot.create(:todo, status: 1)
      Todo.set_status(todo)
      expect(todo.status).to eq("on_going")
    end
  end

  describe "scopeの機能テスト" do
    before do
      @user = FactoryBot.create(:user)
      @todo1 = FactoryBot.create(:todo, user_id: @user.id)
      @todo2 = FactoryBot.create(:todo, :completed, user_id: @user.id)
      @todo3 = FactoryBot.create(:todo, :completed, user_id: @user.id)
      @todo4 = FactoryBot.create(:todo, :no_deadline, user_id: @user.id)
      @todo5 = FactoryBot.create(:todo, :overdue_deadline, user_id: @user.id)
      @todo6 = FactoryBot.create(:todo)
    end
    it ":all_todosで:user_idの一致するTodoを全て取得する" do
      expect(Todo.all_todos(@user)).to include(@todo1, @todo2, @todo3, @todo4, @todo5)
    end
    it ":on_going_todosで:statusがon_goingのTodoを全て取得する" do
      expect(Todo.on_going_todos).to include(@todo1, @todo4, @todo5, @todo6)
    end
    it ":completed_todosで:statusがcompletedのTodoを全て取得する" do
      expect(Todo.completed_todos).to include(@todo2, @todo3)
    end
    it ":no_deadlineで:deadline_timeが設定されていないTodoを全て取得する" do
      expect(Todo.no_deadline).to include(@todo4)
    end
    it ":overdue_deadlineで締切が過ぎているTodoを全て取得する" do
      expect(Todo.overdue_deadline).to include(@todo5)
    end
  end

  describe "overdue_deadline?が正常に作動するか" do
    context "有効な条件" do
      it ":deadline_timeが存在し:deadline_timeが現在時刻より前の時trueを返す" do
        todo = FactoryBot.create(:todo, :overdue_deadline)
        expect(todo.overdue_deadline?).to be_truthy
      end
    end
    context "無効な条件" do
      it ":deadline_timeが存在しない時falseを返す" do
        todo = FactoryBot.create(:todo, :no_deadline)
        expect(todo.overdue_deadline?).to be_falsey
      end
      it ":deadline_timeは存在するが:deadline_timeが現在時刻より後の時falseを返す" do
        todo = FactoryBot.create(:todo)
        expect(todo.overdue_deadline?).to be_falsey
      end
    end
  end
end
