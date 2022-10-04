require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  get '/hello' do
    return erb(:index) #name of the file in view
  end
  
  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you send this message: #{message}"
  end

  get '/names' do
    names = params[:names]
    return "#{names}"
  end

  post '/sort-names' do
    names = params[:names]
    sorted_names = names.split(",").sort.join(",")
    return "#{sorted_names}"
  end
  
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
end
