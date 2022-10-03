require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  get '/hello' do
    name = params[:name]
    return "Hello #{name}"
  end
  
  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you send this message: #{message}"
  end
  
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
end
