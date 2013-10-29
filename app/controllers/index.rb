get '/' do
  # Look in app/views/index.erb
  @categories = Category.all
  erb :index
end

get '/:cat_name' do
  @cat = Category.where("name = ?", params[:cat_name])[0].name.capitalize # namestring
  @cat_id = Category.where("name = ?", params[:cat_name])[0].id # integer
  @posts = Post.where("category_id = ?", @cat_id).all # all dem posts where...

  erb :cat_posts
end
