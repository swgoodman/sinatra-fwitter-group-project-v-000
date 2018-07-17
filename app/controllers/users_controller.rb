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
      @user = User.create(username: params[:username], email: params[:email], password: params[:password_digest])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/tweets/index'
    else
      redirect :'/tweets/new'
  end
end
