class UsersController < ApplicationController


  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params.values.include? ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      "@user.name"
      # redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end
end
