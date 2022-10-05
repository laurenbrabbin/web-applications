require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]

    if invalid_request_parameters? 
      status 400
      return ""
    end

    return erb(:hello)
  end

  def invalid_request_parameters?
    params[:name].gsub!(/[^0-9A-Za-z .]/, '') != params[:name] ? false : true
  end
end
