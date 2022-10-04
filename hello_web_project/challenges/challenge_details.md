## Exercise 1

Work in the same project directory hello_web_project for the following exercises.

Use the Design recipe to test-drive the following route:

# Request:
GET /names

# Expected response (2OO OK):
Julia, Mary, Karim
You should assert that the response status code is 200 and that the response body is the correct string.


## Exercise 2 
Test-drive a new route POST /sort-names which receives a list of names (as a comma-separated string) and return the same list, sorted in alphabetical order.

Here's a description of the expected behaviour:

# Request:
POST http://localhost:9292/sort-names

# With body parameters:
names=Joe,Alice,Zoe,Julia,Kieran

# Expected response (sorted list of names):
Alice,Joe,Julia,Kieran,Zoe


## Exercise 3

Test-drive and update the GET /hello route so it returns the greeting message as an HTML page:

<html>
  <head></head>
  <body>
    <h1>Hello!</h1>
  </body>
</html>

Then, make sure your server is running using rackup and use your web browser to access the page.