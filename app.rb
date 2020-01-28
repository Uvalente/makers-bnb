require 'sinatra/base'
require './lib/place'
require './lib/user'
class Bnb < Sinatra::Base
  enable :sessions, :method_override

  get '/' do 
    @user = session[:user]
    erb :index

  end 

  post '/users' do 
   user = User.new_user(name: params[:name], email: params[:email], phone_number: params[:phonenumber], username: params[:username], password: params[:password])
   session[:user] = user
  
   redirect ('/')
  end 
 get '/places' do 
    @places = Place.all
    erb :places


  end 
  get '/users/new' do 
    erb :'users/new'

  end 
  
  delete '/session' do 
    session.clear
    redirect ('/')
  end 
  
  get '/session/new' do
    erb :'session/new'
  end

  post '/session' do
    session[:user] = User.authenticate(username: params[:username], password: params[:password])
    redirect ('/')
  end

 run! if app_file == $0

end 