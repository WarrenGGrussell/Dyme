# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @songs = Song.all
   # @songs = Song.all.order_by(Upvote.all.song_id.count).desc
  erb :'songs/index'
end

get '/songs/new' do
	erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

post '/songs' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @song = Song.new(
    title: params[:title],
    author:  params[:author],
    url: params[:url],
    user: @current_user
  )
  @current_user.songs << @song
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/upvote/song_id' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
	@upvote = Upvote.new(
		user_id: session[:user_id],
		song_id: params[:song_id]
	)
	@voted_up = true
	redirect '/songs'
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
		redirect '/songs'
	else
		erb :'users/login'
	end
end

get '/users/session/logged_out' do
	session[:user_id] = nil
	erb :'users/logged_out'
end



