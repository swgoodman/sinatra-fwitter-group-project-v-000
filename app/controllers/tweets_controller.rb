class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"tweets/new"
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      @user = User.find(session[:user_id])
      @tweet.user_id = @user.id
      @tweet.save
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if !session[:user_id] == @tweet.user_id
        redirect '/tweets'
      else
        erb :"tweets/edit"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'

    else
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect '/tweets'
    else
      @tweet.delete
      redirect '/tweets'
    end
  end
end
