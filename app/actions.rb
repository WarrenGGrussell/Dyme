# Homepage (Root path)
get '/' do
  erb :index
end

get '/dymepieces' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @dymepieces = Dymepiece.all
  erb :'dymepieces/browse'
end

get '/users/:id' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
	@user = User.find(params[:id])
	if @user
		@dymepieces = Dymepiece.where(:user_id => @user.id)
		# puts "\n\n  #{@dymepieces} \n\n\n\n"
		erb :'users/user_profile'
	else
		redirect :'dymepieces/browse'
	end	
end

post '/dymepieces/delete/:id' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
	d = Dymepiece.find(params[:id])
	d.destroy
	redirect :"users/#{@current_user.id}"
end


get '/dymepieces/new' do
	erb :'dymepieces/new'
end

get '/dymepieces/:id' do
  @dymepiece = Dymepiece.find params[:id]
  if @dymepiece
  	@items = Item.where(:dymepiece_id => @dymepiece.id)
  	erb :'dymepieces/show'
  else
  	redirect :'dymepieces/browse'
  end
end

post '/dymepieces' do
	@current_user = User.find(session[:user_id]) if session[:user_id]
  @dymepiece = Dymepiece.new(
    topic: params[:topic],
    user: @current_user
  )
  if @dymepiece.save
    redirect "/dymepieces/#{@dymepiece.id}/items/new_item"
  else
    erb :'dymepiece/new'
  end
end

get "/dymepieces/:dymepiece_id/items/new_item" do 
  @dymepiece = Dymepiece.find params[:dymepiece_id]
  erb :'dymepieces/items/new_item'
end

post '/items' do 
  @current_user = User.find(session[:user_id]) if session[:user_id]
  @current_dymepiece = Dymepiece.find(params[:dymepiece_id])
  1.upto(10) do |i|
  	img_url = ("img_url" + i.to_s).to_sym
  	description = ("description" + i.to_s).to_sym
		item = Item.new(
	    img_url: params[img_url],
	    description: params[description],
	    user: @current_user,
	    dymepiece: @current_dymepiece
    )
	end
	if item.save()
 		redirect "/dymepieces/#{@current_dymepiece.id}"
 	else
 		erb :'dymepieces/items/new_item'
 	end
end

get '/dymepieces/items/:id' do 
  @item = Item.find params[:id]
  erb :'dymepieces/items/edit_item'
end

post '/dymepieces/items/:item_id/edit_item' do
  @item = Item.find params[:item_id]
  @item.update(description: params[:description],img_url: params[:img_url])
  @item.save
  redirect "/dymepieces/#{@item.dymepiece_id}"

  # item.dymepiece_id"
end





get '/users/signup' do
	erb :'users/signup'
end

get '/users/login' do
	erb :'users/login'
end

# get '/users/:id' do
# 	@current_user = User.find(session[:user_id]) if session[:user_id]
# 	erb :'users/user_profile'
# end

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
	@user = User.find_by(
		email: params[:email],
		password: params[:password]
	)
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



