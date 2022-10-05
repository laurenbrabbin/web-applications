require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "should return a list of all albums" do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a><br />')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a><br />')
    end
  end
  context "GET /artists" do
    it "returns a list of all artists with clickable link" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
      expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />')
    end
  end
  context 'GET /artists/new' do
    it "returns the form pageto create a new artist" do
      response = get('/artists/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="POST" method="/artists">')
      expect(response.body).to include('<input type="text" name="artist_name">')
      expect(response.body).to include('<input type="text" name="artist_genre">')
    end
  end
  context 'GET /albums/new' do
    it "returns the form pageto create a new album" do
      response = get('/albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include('<input type="text" name="album_title">')
      expect(response.body).to include('<input type="text" name="album_release_year">')
      expect(response.body).to include('<input type="text" name="album_artist_id">')
    end
  end
  context "POST /albums" do
    it "returns a success page" do
      response = post(
        '/albums', 
        album_title: 'Dancing Queen', 
        album_release_year: '1976', 
        album_artist_id: '2')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your album has been added!</p>')
    end
    it "responds with 400 status if parameters are invalid" do
      response = post(
        '/albums', 
        title: nil, 
        release_year: nil, 
        artist_id: '2')
      
      expect(response.status).to eq(400)
    end
  end
  context "POST /artists" do
    it "returns a success page" do
      response = post(
        '/artists', 
        artist_name: 'Rihanna', 
        artist_genre: 'Pop')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your artist has been added!</p>')
    end
    it "responds with 400 status if parameters are invalid" do
      response = post(
        '/artists', 
        fakename: nil, 
        incorrectgenre: nil)
      
      expect(response.status).to eq(400)
    end
  end
  context 'GET /albums/:id' do
    it "should return info about album 2" do #there is no artist with id one
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: ABBA')
    end
  end
  context 'GET /artists/:id' do
    it "returns info about artist 1" do
      response = get("/artists/1")
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end
  end
end
