get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  p "*" * 50
  p params
  p "*" * 50
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  p @access_token.params.inspect
  # oauth_token
  # oauth_secret
  # screen_name

  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  new_user = User.new(username: @access_token.params[:screen_name],
                      oauth_token: @access_token.params[:oauth_token],
                      oauth_secret: @access_token.params[:oauth_token_secret])

  if new_user.save
    session[:username] = new_user.username
    session[:oauth_token] = new_user.oauth_token
    session[:oauth_token_secret] = new_user.oauth_secret
  end

  p "success"

  redirect '/'

end
