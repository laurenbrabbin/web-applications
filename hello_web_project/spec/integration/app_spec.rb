require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /names" do
    it 'returns 200 OK' do
      response = get('http://localhost:9292/names?names=Julia, Mary, Karim')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end

    it 'returns 404 Not Found' do
      response = get('http://localhost:9292/named')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
  
    end
  end
  context "POST /sort-names" do
    it 'returns 200 OK' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end

    it 'returns 404 Not Found' do
      response = get('/sort-named')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end