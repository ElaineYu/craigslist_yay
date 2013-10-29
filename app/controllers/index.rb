get '/' do
  # Look in app/views/index.erb
  @categories = Category.all
  erb :index
end

#SHOW CATEGORY POSTS

get '/:cat_name' do
  @cat = Category.where("name = ?", params[:cat_name]) # category object
  @cat_id = @cat.first.id # integer
  puts @cat_id
  @posts = Post.where("category_id = ?", @cat_id).all # all dem posts where...

  erb :cat_posts
end

# CREATE A NEW POST

get '/:cat_name/create_post' do
  # display the form so the user can make a new post
     @cat = Category.where("name = ?", params[:cat_name]).first # category object

     erb :create_post
end

#SHOW POST DETAILS

get '/:cat_name/:item_id' do
  @cat = Category.where("name = ?", params[:cat_name]) # category object
  @cat_id = @cat.first.id # integer
  @posts = Post.where("category_id = ?", @cat_id) # all dem posts where...
  @item = Post.find(params[:item_id])

  erb :post_details
end

#GET USER INFO

post '/:cat_name' do
    @cat = Category.where("name = ?", params[:cat_name]) # category object

    Category.where("name = ?", @cat.first.name)[0].posts << Post.create(title: params[:title], 
                                                            description: params[:description], 
                                                            location: params[:location], 
                                                            price: params[:price], 
                                                            email: params[:email])
    @posts = Post.where("category_id = ?", @cat_id).all # all dem posts where...

    redirect to("/#{@cat.first.name}")
end

#UPDATE

get '/:cat_name/:item_id/edit' do
  #Find the post
  @cat = Category.where("name = ?", params[:cat_name]) # category object
  @cat_id = @cat.first.id # integer
  @posts = Post.where("category_id = ?", @cat_id) # all dem posts where...
  @item = Post.find(params[:item_id])
  
  erb :edit_post
end

post '/:cat_name/:item_id/edit' do
    @item = Post.find(params[:item_id])
    @cat = Category.where("name = ?", params[:cat_name]) # category object
    @item.update_attributes(title: params[:title],
                            description: params[:description],
                            location: params[:location],
                            price: params[:price],
                            email: params[:email])
    @posts = Post.where("category_id = ?", @cat_id).all # all dem posts where...

    redirect to("/#{@cat.first}")
end

get '/:cat_name/:item_id/delete' do
  @item = Post.find(params[:item_id])
  @cat = Category.where("name = ?", params[:cat_name]) # category object
  @item.destroy

  redirect to("/#{@cat.first.name}")
end




