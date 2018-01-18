
require 'sinatra'
# require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/activity'
require_relative 'models/comment'
require_relative 'models/place'
require_relative 'models/user'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def admin?
    if logged_in? && current_user.email == "wv@ga.co"
      return true
    else
      return false
    end
  end

  def logged_in?
    !!current_user
  end
end


get '/' do
  @places = Place.all
  erb :index
end

get '/login' do
  erb :login
end

get '/sign_up' do
  erb :sign_up
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

get '/places/:id' do
  redirect '/login' unless logged_in?
  @place = Place.find(params[:id])
  @comments = Comment.where(place_id: @place.id)
  @activities = Activity.where(place_id: @place.id)
  erb :showcase
end

get '/places/:id/edit' do
  redirect '/login' unless admin?
  @place = Place.find(params[:id])
  erb :edit
end

put '/places/:id' do
  redirect '/login' unless admin?
  place = Place.find(params[:id])
  place.name = params[:name]
  place.image_url = params[:image_url]
  place.locale = params[:locale]
  place.description = params[:description]
  place.save
  redirect "/places/#{params[:id]}"
end

post '/comments' do
  redirect '/login' unless logged_in?
  comment = Comment.new
  comment.body = params[:body]
  comment.place_id = params[:place_id]
  comment.save
  redirect "/places/#{comment.place_id}"
end

post '/users' do
  user_check = User.find_by(email: params[:email])
  @user_checker = user_check
  if user_check.email == params[:email]
    @new_user_marker = 1
    erb :sign_up
  else
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.save
    @user_temp = params[:email]
    session[:user_id] = user.id
    redirect '/'
  end
end

delete '/places/:id' do
  redirect '/login' unless admin?
  place = Place.find(params[:id])
  place.destroy
  redirect '/'
end

get '/new_dest' do
  redirect '/login' unless logged_in?
  erb :new_dest
end

post '/places' do
  redirect '/login' unless logged_in?
  place = Place.new
  place.name = params[:name]
  place.image_url = params[:image_url]
  place.locale = params[:locale]
  place.description = params[:description]
  place.save
  redirect '/'
end

get '/showcase' do
  redirect '/login' unless logged_in?
  erb :showcase
end

post '/activities' do
  redirect '/login' unless logged_in?
  activity = Activity.new
  activity.things_to_do = params[:things_to_do]
  activity.place_id = params[:place_id]
  activity.save
  redirect "/places/#{params[:place_id]}"
end








#
