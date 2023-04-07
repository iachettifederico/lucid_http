require "lucid_http"

RSpec.describe "forms" do
  let(:client) { LucidHttp::Client.new(base_url: "http://localhost:9292") }

  it "can receive a query string" do
    response = client.POST("/params?items[]=book1&items[]=book2", formatter: :json)

    expect(response.body).to eql({ "items" => ["book1", "book2"]})
  end

  it "can receive a form" do
    form = {
      item:     "book",
      quantity: 1,
      price:    50.0,
      title:    "The complete guide to doing absolutely nothing at all."
    }
    response = client.POST("/params", form: form, formatter: :json)

    expected_response = {
      "item"     => "book",
      "quantity" => "1",
      "price"    => "50.0",
      "title"    => "The complete guide to doing absolutely nothing at all."
    }

    expect(response.body).to eql(expected_response)
  end

end
