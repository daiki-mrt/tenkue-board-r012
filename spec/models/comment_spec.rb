require 'rails_helper'
describe Comment do
  describe '#create' do
    context 'can save' do
      it "コメント(text)  存在すれば登録できること" do
        comment = build(:comment)
        expect(comment).to be_valid
      end
      
      it "コメント(text)  140文字以内であれば登録できること" do
        comment = build(:comment, text: "コメント" * 35)
        expect(comment).to be_valid
      end

    end

    context 'can not save' do
      it "コメント(text)  存在しない場合は登録できないこと" do
        comment = build(:comment, text: nil)
        comment.valid?
        expect(comment.errors[:text]).to include("を入力してください")
      end

      it "コメント(text)  140文字を超える場合は登録できないこと" do
        comment = build(:comment, text: "テスト" * 47)
        comment.valid?
        expect(comment.errors[:text]).to include("は140文字以内で入力してください")
      end

    end

  end
end