require "lucid_http"

RSpec.describe "base url" do
  it "has a default base url" do
    LucidHttp.reset_default_base_url!

    expect(LucidHttp.base_url).to eql("http://localhost:9292")
  end

  it "can receive the base_url in the constructor" do
    client = LucidHttp::Client.new(base_url: "http://localhost:9292")

    expect(client.base_url).to eql("http://localhost:9292")
  end

  it "can set the base_url using an environment variable" do
    ENV["LUCID_HTTP_BASE_URL"] = "http://test.com"

    client = LucidHttp::Client.new

    expect(client.base_url).to eql("http://test.com")
    expect(LucidHttp.base_url).to eql("http://test.com")
  end

end
