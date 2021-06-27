require 'rails_helper'

RSpec.describe User, type: :model do
  it ":name,:email,:passwordがあれば有効なこと" do
    user = User.new(
      name: "masu",
      email: "test@example.com",
      password: "hoge"
    )
    expect(user).to be_valid
  end
  it ":nameがなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  it ":emailがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  it ":passwordがなければ無効な状態であること" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  it "重複した:emailなら無効な状態であること" do
    User.create(
      name: "masu",
      email: "test@example.com",
      password: "hoge"
    )
    user = User.new(
      name: "nobu",
      email: "test@example.com",
      password: "hogehoge"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  it ":nameの文字数が21文字以上の場合無効な状態であること" do
    user = User.new(name: "a" * 21)
    user.valid?
    expect(user.errors[:name]).to include("は20文字以内で入力してください")
  end
  it ":emailの文字数が51文字以上の場合無効な状態であること" do
    user = User.new(email: "a" * 51)
    user.valid?
    expect(user.errors[:email]).to include("は50文字以内で入力してください")
  end
  it ":passwordの文字数が21文字以上の場合無効な状態であること" do
    user = User.new(password: "a" * 21)
    user.valid?
    expect(user.errors[:password]).to include("は20文字以内で入力してください")
  end
  it ":nameの文字数が20文字の場合有効であること" do
    user = User.new(name: "a" * 20)
    user.valid?
    expect(user.errors[:name]).to eq([])
  end
  it ":emailの文字数が50文字の場合有効であること" do
    user = User.new(email: "a" * 50)
    user.valid?
    expect(user.errors[:email]).to eq([])
  end
  it ":passwordの文字数が20文字の場合有効であること" do
    user = User.new(password: "a" * 20)
    user.valid?
    expect(user.errors[:password]).to eq([])
  end
end
