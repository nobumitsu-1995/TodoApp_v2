require 'rails_helper'

RSpec.describe Todo, type: :model do
  it ":content, :start_time, :status, :user_idがあれば有効なこと" do
    expect(FactoryBot.create(:todo)).to be_valid
  end
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
  it ":contentの文字数が200文字の場合有効であること" do
    todo =  FactoryBot.build(:todo, content: "a" * 200)
    todo.valid?
    expect(todo.errors[:content]).to be_empty
  end

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
