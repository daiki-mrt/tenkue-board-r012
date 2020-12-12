require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "掲示板投稿" do
    before do
      @post = create(:post)
    end
    
    context "投稿できるとき" do
      it "正しく情報が入力されていれば投稿できる" do
        expect(@post).to be_valid
      end
      it "投稿が140文字だと投稿できる" do
        @post.content = "0123456789" * 14
        expect(@post).to be_valid
      end
    end
    context "投稿できないとき" do
      it "内容が空だと投稿できない" do
        @post.content = nil
        @post.valid?
        expect(@post.errors[:content]).to include("を入力してください")
      end
      it "内容が141文字以上だと投稿できない" do
        @post.content = "0123456789" * 14 + "0"
        @post.valid?
        expect(@post.errors[:content]).to include("は140文字以内で入力してください")
      end
      it "ユーザが紐付いていないと投稿できない" do
        @post.user = nil
        @post.valid?
        expect(@post.errors[:user]).to include("を入力してください")
      end
    end
  end
end
