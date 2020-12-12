require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "Likeの保存" do
    before do
      @user = create(:user)
      @post = create(:post)
    end
    it "ユーザと掲示板投稿が紐付いていれば保存できる" do
      like = Like.new(user_id: @user.id, post_id: @post.id)
      expect(like).to be_valid
    end
    it "ユーザが紐付いていないと保存できない" do
      like = Like.new(post_id: @post.id)
      like.valid?
      expect(like.errors[:user]).to include("を入力してください")
    end
    it "掲示板投稿が紐付いていないと保存できない" do
      like = Like.new(user_id: @user.id)
      like.valid?
      expect(like.errors[:post]).to include("を入力してください")
    end
  end
  
  describe "likeのレコードが存在するか確認する" do
    before do
      @user = create(:user)
      @post = create(:post)
    end
    it "ユーザと掲示板投稿の組み合わせが存在していたらtrueを返す" do
      already_liked = Like.create(user_id: @user.id, post_id: @post.id)
      expect(Like.exist_or_not?(already_liked)).to be true
    end
    it "ユーザと掲示板投稿の組み合わせが、まだ存在していなければfalseを返す" do
      not_liked = Like.new(user_id: @user.id, post_id: @post.id)
      expect(Like.exist_or_not?(not_liked)).to be false
    end
  end
end
