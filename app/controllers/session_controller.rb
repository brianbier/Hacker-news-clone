#Index Page
get '/' do 
  erb :'/'
end

#sign in page 
get '/login' do
  erb :'/login'
end

#sign in user
post '/login' do
  user = User.find_by(email: params[:user][:email])
  if user && user.authenticate(params[:user][:password])
    session[:user_session_id] = user.id
    redirect '/' #Requires index to where to redirect
  else
    @errors = ["Wrong username or password"]
    erb :'sessions/new'
  end
end


#sign up page
get '/users/new' do
  erb :'/new'
end

#Create new User
post '/users' do
 @user = User.new(params[:user])
   if @user.save
    session[:user_id] = @user.id
     redirect "/users/#{@user.id}"
   else
    @errors = user.errors.full_messages
    erb :'users/new'
   end
end

#User delete session
delete '/logout' do
  session.clear
  redirect '/'
end