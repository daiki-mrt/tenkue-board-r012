crumb :top do
  link "投稿一覧", root_path
end

crumb :post_new do
  link "新規投稿"
  parent :top
end

crumb :post_edit do |post|
  link "#{post.user.name}さんの投稿(#{post.id})の編集"
  parent :top
end

crumb :post_show do |post|
  link "#{post.user.name}さんの投稿(#{post.id})"
  parent :top
end