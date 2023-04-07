require "lucid_http"

RSpec.describe "all verbs", :vcr do
  let(:client) { LucidHttp::Client.new(base_url: "http://localhost:9292") }

  it "can make a GET request" do
    response = client.GET("/verb")

    expect(response.body).to eql("<GET>")
    expect(response.verb).to eql("GET")
  end

  it "can make a POST request" do
    response = client.POST("/verb")

    expect(response.body).to eql("<POST>")
    expect(response.verb).to eql("POST")
  end

  it "can make a PUT request" do
    response = client.PUT("/verb")

    expect(response.body).to eql("<PUT>")
    expect(response.verb).to eql("PUT")
  end

  it "can make a PATCH request" do
    response = client.PATCH("/verb")

    expect(response.body).to eql("<PATCH>")
    expect(response.verb).to eql("PATCH")
  end

  it "can make a DELETE request" do
    response = client.DELETE("/verb")

    expect(response.body).to eql("<DELETE>")
    expect(response.verb).to eql("DELETE")
  end

  it "can make a OPTIONS request" do
    response = client.OPTIONS("/verb")

    expect(response.body).to eql("<OPTIONS>")
    expect(response.verb).to eql("OPTIONS")
  end
end
