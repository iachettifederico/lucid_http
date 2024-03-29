require "lucid_http"

RSpec.describe "root context", :vcr do
  it "can make a expect request at root context" do
    expect(GET("/verb")).to eql("<GET>")
    
    expect(verb).to eql("GET")
  end

  it "can make a GET request at root context" do
    GET("/verb")

    expect(body).to eql("<GET>")
    expect(verb).to eql("GET")
  end

  it "can make a POST request at root context" do
    POST("/verb")

    expect(body).to eql("<POST>")
    expect(verb).to eql("POST")
  end

  it "can make a PUT request at root context" do
    PUT("/verb")

    expect(body).to eql("<PUT>")
    expect(verb).to eql("PUT")
  end

  it "can make a PATCH request at root context" do
    PATCH("/verb")

    expect(body).to eql("<PATCH>")
    expect(verb).to eql("PATCH")
  end

  it "can make a DELETE request at root context" do
    DELETE("/verb")

    expect(body).to eql("<DELETE>")
    expect(verb).to eql("DELETE")
  end

  it "can make a OPTIONS request at root context" do
    OPTIONS("/verb")

    expect(body).to eql("<OPTIONS>")
    expect(verb).to eql("OPTIONS")
  end

  it "can make a GET request at root context and get all the information" do
    GET("/hello")

    expect(body).to eql("<h1>Hello World!</h1>")
    expect(status).to eql("200 OK")
    expect(content_type).to eql("text/html")
    expect(url).to eql("http://localhost:9292/hello")
    expect(path).to eql("/hello")
  end

  it "can format json responses as hashes at root context" do
    GET("/hello_world.json", formatter: :json)

    expected_response = {
      "content"   => "You said: hello_world",
      "keyword"   => "hello_world",
      "timestamp" => "2016-12-31 15:00:42 -0300",
      "method"    => "GET",
      "status"    => 200,
    }

    expect(body).to eql(expected_response)
    expect(content_type).to eql("application/json")
  end

  it "can receive a form at root context" do
    form = {
      item:     "book",
      quantity: 1,
      price:    50.0,
      title:    "The complete guide to doing absolutely nothing at all."
    }

    POST("/params", form: form, formatter: :json)

    expected_response = {
      "item"     => "book",
      "quantity" => "1",
      "price"    => "50.0",
      "title"    => "The complete guide to doing absolutely nothing at all."
    }

    expect(body).to eql(expected_response)
  end

  it "can get an error at root context" do
    GET("/500")

    expect(status).to eql("500 Internal Server Error")
    expect(error).to eql("ArgumentError: wrong number of arguments (given 0, expected 2+) (ArgumentError)")
  end

end
