# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all 

    return erb(:albums)
  end

  post '/albums' do
    if invalid_request_album_parameters?
      status 400
      return ""
    end
    
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:album_title]
    new_album.release_year = params[:album_release_year]
    new_album.artist_id = params[:album_artist_id]

    repo.create(new_album)

    return erb(:album_created)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all 
    
    return erb(:artists)
  end

  post '/artists' do
    if invalid_request_artist_parameters?
      status 400
      return ""
    end

    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:artist_name]
    new_artist.genre = genre = params[:artist_genre]

    repo.create(new_artist)

    return erb(:artist_created)
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/albums/:id' do
    artist_repo = ArtistRepository.new
    album_repo = AlbumRepository.new
    
    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.id)
    
    erb(:album)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    erb(:artist)
  end

  def invalid_request_album_parameters?
    params[:album_title] == "" || params[:album_title] == nil || params[:album_release_year] == "" || params[:album_release_year] == nil || params[:album_artist_id] == "" || params[:album_artist_id] == nil
  end
  
  def invalid_request_artist_parameters?
    params[:artist_name] == "" || params[:artist_name] == nil || params[:artist_genre] == "" || params[:artist_genre] == nil
  end
end