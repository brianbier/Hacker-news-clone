#sign in page 
get '/login' do
  erb :'users/login'
end

#sign in user
post '/login' do
  user = User.find_by(user_name: params[:user][:user_name])
  if user && user.authenticate(params[:user][:password])
    session[:user_session_id] = @user.id
    redirect '/' #Requires index to where to redirect
  else
    @errors = ["Wrong username or password"]
    erb :'/users/login'
  end
end


#sign up page
get '/register' do
  erb :'users/new'
end

#Create new User
post '/user' do
 @user = User.new(params[:user])
   if @user.save
     session[:user_session_id] = @user.id
     redirect '/'
     # redirect "/users/#{@user.id}"
   else
    @errors = @user.errors.full_messages
    erb :'users/new'
   end
end

#User delete session
delete '/logout' do
  session.clear
  redirect '/'
end