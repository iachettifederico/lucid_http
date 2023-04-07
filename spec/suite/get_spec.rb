require "lucid_http"

RSpec.describe "GET", :vcr do
  let(:client) { LucidHttp::Client.new(base_url: "http://localhost:9292") }
  it "can retrieve the base url" do
    expect(client.base_url).to eql("http://localhost:9292")
  end

  it "can make a request" do
    response = client.GET("/hello")

    expect(response.body).to eql("<h1>Hello World!</h1>")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/hello")
    expect(response.path).to eql("/hello")
  end

  it "can make more than one request" do
    response = client.GET("/hello")

    expect(response.body).to eql("<h1>Hello World!</h1>")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/hello")
    expect(response.path).to eql("/hello")

    response = client.GET("/hello/you")

    expect(response.body).to eql("<h1>Hello, You!</h1>")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/hello/you")
    expect(response.path).to eql("/hello/you")
  end

  it "can retourn a different status code" do
    response = client.GET("/redirect_me")

    expect(response.body).to eql("")
    expect(response.status).to eql("302 Found")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/redirect_me")
    expect(response.path).to eql("/redirect_me")
  end

  it "can follow redirects" do
    response = client.GET("/redirect_me", follower: :follow)

    expect(response.body).to eql("You have arrived here due to a redirection.")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/redirect_me")
    expect(response.path).to eql("/redirect_me")
  end

  it "can get an error" do
    response = client.GET("/500")

    expect(response.status).to eql("500 Internal Server Error")
    expect(response.error).to eql("ArgumentError: wrong number of arguments (given 0, expected 2+) (ArgumentError)")
  end

  it "returns no error if there is no error" do
    response = client.GET("/not_500")

    expect(response.status).to eql("200 OK")
    expect(response.error).to eql("No error found")
  end

  it "can format json responses as hashes" do
    response = client.GET("/hello_world.json", formatter: :json)

    expected_response = {
      "content"   => "You said: hello_world",
      "keyword"   => "hello_world",
      "timestamp" => "2016-12-31 15:00:42 -0300",
      "method"    => "GET",
      "status"    => 200,
    }

    expect(response.body).to eql(expected_response)
    expect(response.content_type).to eql("application/json")
  end
end
