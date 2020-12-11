require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメント投稿" do
    before do
      @comment = create(:comment)
    end

    context "コメント投稿できるとき" do
      it "正しく情報が入力されていれば投稿できる" do
        expect(@comment).to be_valid
      end
      it "投稿が140文字なら投稿できる" do
        @comment.comment = "0123456789" * 14
        expect(@comment).to be_valid
      end
    end
    context "コメント投稿できないとき" do
      it "内容が空だと投稿できない" do
        @comment.comment = nil
        @comment.valid?
        expect(@comment.errors[:comment]).to include("を入力してください")
      end
      it "内容が141文字以上だと投稿できない" do
        @comment.comment = "0123456789" * 14 + "0"
        @comment.valid?
        expect(@comment.errors[:comment]).to include("は140文字以内で入力してください")
      end
      it "ユーザが紐付いていないと投稿できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors[:user]).to include("を入力してください")
      end
      it "掲示板が紐付いていないと投稿できない" do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors[:post]).to include("を入力してください")
      end
    end
  end
end
