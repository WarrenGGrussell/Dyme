# Homepage (Root path)
get '/' do
  erb :index
end

get '/dymepieces' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @dymepieces = Dymepiece.all
  erb :'dymepieces/browse'
end

get '/dymepieces/new' do
	erb :'dymepieces/new'
end

get '/dymepieces/:id' do
  @dymepiece = Dymepiece.find params[:id]
  erb :'dymepieces/show'
end

post '/dymepieces' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @dymepiece = Dymepiece.new(
    topic: params[:topic],
    user: @current_user
  )
  if @dymepiece.save
    redirect '/dymepieces/:id'
  else
    erb :'dymepiece/new'
  end
end

get '/users/signup' do
	erb :'users/signup'
end

get '/users/login' do
	erb :'users/login'
end

get '/users/profile' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
	erb :'users/user_profile'
end

post '/users' do
	@user = User.new(
		username: params[:username],
		email: params[:email],
		password: params[:password]
	)
	if @user.save
		redirect '/users/login'
	else
		erb :'users/signup'
	end
end

post '/users/login' do
	@user = User.where(
		email: params[:email],
		password: params[:password]
	).first
	if @user
		session[:user_id] = @user.id
		@current_user = @user
		redirect '/dymepieces'
	else
		erb :'users/login'
	end
end

get '/users/session/logged_out' do
	session[:user_id] = nil
	erb :'users/logged_out'
end



