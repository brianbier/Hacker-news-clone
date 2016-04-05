#Index Page
get '/' do 
  @posts = Post.all
  if logged_in?
    @user = User.find(session[:user_session_id])
  end
  erb :'/index'
end

#Include a new post
get '/posts/new' do 
  erb :'posts/new'
end


#New post to data base
post '/posts' do 
 @post = Post.new(params[:post])
 @post.user_id = session[:user_session_id]
 if @post.save
  redirect '/'
 else
  @errors = @post.errors.full_messages
  erb :'/posts/new'
 end
end


# Display a specific Post
get '/posts/:id' do 
  @post = Post.find(params[:id])
  erb :'posts/show'
end


# Delete a post
delete '/posts/:id' do 
  @post = Post.find(params[:id])
  if @post.user.id == session[:user_session_id]
    @post.destroy
    redirect "/user/#{session[:user_session_id]}"
  else
    redirect '/'
  end
end


get '/posts/:id/edit' do 
  if current_user 
    @post = Post.find(params[:id])
    erb :'/posts/edit'
  else
    @errors = "Sorry you are not allowed to delete this page"
    erb :'/posts/show'
  end
end


put '/posts/:id' do 
  post = Post.find(params[:id])
  post.update(params[:post])
  redirect "posts/#{post.id}"
end

