require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validationチェック" do
    context "有効な条件" do
      it ":name,:email,:passwordがあれば有効なこと" do
        expect(FactoryBot.create(:user)).to be_valid
      end
      it ":nameの文字数が20文字の場合有効であること" do
        user = FactoryBot.build(:user, name: "a" * 20)
        user.valid?
        expect(user.errors[:name]).to eq([])
      end
      it ":emailの文字数が50文字の場合有効であること" do
        user = FactoryBot.build(:user, email: "a" * 50)
        user.valid?
        expect(user.errors[:email]).to eq([])
      end
      it ":passwordの文字数が20文字の場合有効であること" do
        user = FactoryBot.build(:user, password: "a" * 20)
        user.valid?
        expect(user.errors[:password]).to eq([])
      end
    end
    context "無効な条件" do
      it ":nameがなければ無効な状態であること" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
      it ":emailがなければ無効な状態であること" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it ":passwordがなければ無効な状態であること" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it "重複した:emailなら無効な状態であること" do
        FactoryBot.create(:user, email: "test@example.com")
        user = FactoryBot.build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します")
      end
      it ":nameの文字数が21文字以上の場合無効な状態であること" do
        user = FactoryBot.build(:user, name: "a" * 21)
        user.valid?
        expect(user.errors[:name]).to include("は20文字以内で入力してください")
      end
      it ":emailの文字数が51文字以上の場合無効な状態であること" do
        user = FactoryBot.build(:user, email: "a" * 51)
        user.valid?
        expect(user.errors[:email]).to include("は50文字以内で入力してください")
      end
      it ":passwordの文字数が21文字以上の場合無効な状態であること" do
        user = FactoryBot.build(:user, password: "a" * 21)
        user.valid?
        expect(user.errors[:password]).to include("は20文字以内で入力してください")
      end
    end
  end
end
