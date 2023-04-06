require "lucid_http"

RSpec.describe "pepe" do
  let(:client) { LucidHttp::Client.new(base_url: "http://localhost:9292") }
  it "does something" do

    expect(client.base_url).to eql("http://localhost:9292")
  end

  it "does something" do
    response = client.GET("/hello")

    expect(response.body).to eql("<h1>Hello World!</h1>")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/hello")
    expect(response.path).to eql("/hello")
  end

  it "does something" do
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

  it "does something" do
    response = client.GET("/redirect_me")

    expect(response.body).to eql("")
    expect(response.status).to eql("302 Found")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/redirect_me")
    expect(response.path).to eql("/redirect_me")
  end

  it "does something" do
    response = client.GET("/redirect_me", follower: LucidHttp::Follower::Follow.new)

    expect(response.body).to eql("You have arrived here due to a redirection.")
    expect(response.status).to eql("200 OK")
    expect(response.content_type).to eql("text/html")
    expect(response.url).to eql("http://localhost:9292/redirect_me")
    expect(response.path).to eql("/redirect_me")
  end

  it "does something" do
    response = client.GET("/500")

    expect(response.status).to eql("500 Internal Server Error")
    expect(response.error).to eql("ArgumentError: wrong number of arguments (given 0, expected 2+) (ArgumentError)")
  end

end
