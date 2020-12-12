require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザ登録" do
    before do
      @user = create(:user)
    end

    context "ユーザ登録できるとき" do
      it "すべての情報が正しく入力されて入れば保存できる" do
        expect(@user).to be_valid
      end
    end

    context "ユーザ登録できないとき" do
      it "名前が入力されていないと登録できない" do
        @user.name = nil
        @user.valid?
        expect(@user.errors[:name]).to include("を入力してください")
      end
      it "メールアドレスに全角文字が含まれていると登録できない" do
        @user.email = "ＡＢＣ@abc.com"
        @user.valid?
        expect(@user.errors[:email]).to include("は不正な値です")
      end
      it "パスワードが7文字だと登録できない" do
        @user.password = "abcd123"
        @user.valid?
        expect(@user.errors[:password]).to include("は不正な値です")
      end
      it "パスワードが33文字だと登録できない" do
        @user.password = "abcd1234" * 4 + "a"
        @user.valid?
        expect(@user.errors[:password]).to include("は不正な値です")
      end
      it "パスワードが半角英字のみだと登録できない" do
        @user.password = "abcdefgh"
        @user.valid?
        expect(@user.errors[:password]).to include("は不正な値です")
      end
      it "パスワードが半角数字のみだと登録できない" do
        @user.password = "12345678"
        @user.valid?
        expect(@user.errors[:password]).to include("は不正な値です")
      end
      it "パスワードに全角が含まれていると登録できない" do
        @user.password = "ＡＢＣＤ１２３４"
        @user.valid?
        expect(@user.errors[:password]).to include("は不正な値です")
      end
      it "パスワード確認がパスワードと一致していないと登録できない" do
        @user.password_confirmation = "ABCD1234"
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end

  describe "ゲストユーザの登録・検索" do
    it "self.guestメソッドはゲストユーザを返す" do
      guest_user = User.guest
      expect(guest_user.name).to eq "ゲストユーザ"
      expect(guest_user.email).to eq "guest@example.com"
    end
  end
end
