crumb :root do
  link "投稿一覧", root_path
end

# post/new
crumb :post_new do
  link "新規投稿", new_post_path
end

# post/show
crumb :post_show do |post|
  link "#{post.user.name}さんの投稿(#{post.id})", post
  parent :root
end