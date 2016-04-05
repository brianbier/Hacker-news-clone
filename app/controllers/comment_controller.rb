post '/comment' do 
   @comment = Comment.new(params[:comment])
   @comment.user_id = session[:user_session_id]
   if @comment.save && logged_in?
    # binding.pry
    redirect "/posts/#{@comment.post_id}"
   else
    # @errors = @comment.errors.full_messages
    redirect '/posts/show/?error=Wrong username or password'
   end
end


get '/comments/:id/new' do 
  erb :'/comments/new'
end


post '/comment/reply' do 

end