#Index Page
get '/' do 
  erb :'/index'
end

#Include a new post
get '/posts/new' do 
  erb :'posts/new'
end

#New post to data base

post '/posts' do 
 @post = Post.new(params[:post], user_id: session[:user_id])
 if @post.save
  redirect '/'
 else
  @errors = @post.errors.full_messages
  erb :'/posts/new'
 end
end