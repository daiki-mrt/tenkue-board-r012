require 'rails_helper'
describe Post do
  describe '#create' do
    context 'can save' do
      it "投稿内容(text)  存在すれば登録できること" do
        post = build(:post)
        expect(post).to be_valid
      end
      
      it "投稿内容(text)  140文字以内であれば登録できること" do
        post = build(:post, text: "投稿内容" * 35)
        expect(post).to be_valid
      end

    end

    context 'can not save' do
      it "投稿内容(text)  存在しない場合は登録できないこと" do
        post = build(:post, text: nil)
        post.valid?
        expect(post.errors[:text]).to include("を入力してください")
      end

      it "投稿内容(text)  140文字を超える場合は登録できないこと" do
        post = build(:post, text: "テスト" * 47)
        post.valid?
        expect(post.errors[:text]).to include("は140文字以内で入力してください")
      end

    end

  end
end