{{ POST}} {{/sort-names }} Route Design Recipe
Copy this design recipe template to test-drive a Sinatra route.

## 1. Design the Route Signature
You'll need to include:

    # Request:
    POST http://localhost:9292/sort-names

    # With body parameters:
    names=Joe,Alice,Zoe,Julia,Kieran

    # Expected response (sorted list of names):
    Alice,Joe,Julia,Kieran,Zoe

## 2. Design the Response
The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return 200 OK if the post exists, but 404 Not Found if the post is not found in the database.

Your response might return plain text, JSON, or HTML code.

Replace the below with your own design. Think of all the different possible responses your route will return.

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->
  ## request
  POST http://localhost:9292/sort-names?names=Joe,Alice,Zoe,Julia,Kieran

  ## expected response(200 ok)
  Alice,Joe,Julia,Kieran,Zoe

<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->

  ## request
  POST http://localhost:9292/sort-named

  ## expected response(404)
  returns 404 error message


## 3. Write Examples
Replace these with your own design.

# Request:
POST /sort-names?names=Joe,Alice,Zoe,Julia,Kieran

# Expected response:
Alice,Joe,Julia,Kieran,Zoe


# Request:
GET /sort-named

# Expected response:
Response for 404 Not Found


## 4. Encode as Tests Examples

# EXAMPLE
# file: spec/integration/application_spec.rb

```ruby 
require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

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
```

## 5. Implement the Route
Write the route and web server code to implement the route behaviour.