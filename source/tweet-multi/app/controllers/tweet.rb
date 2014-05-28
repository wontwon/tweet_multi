# POST Requests

post '/tweet/create' do

  client = Twitter::REST::Client.new do |config|
    config.consumer_key =  ENV['CONSUMER_KEY']
    config.consumer_secret= ENV['CONSUMER_SECRET']
    config.access_token = session[:oauth_token]
    config.access_token_secret = session[:oauth_token_secret]
  end

  client.update(params[:text])

end
