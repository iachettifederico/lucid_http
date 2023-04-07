require "lucid_http"

RSpec.describe "all verbs" do
  let(:client) { LucidHttp::Client.new(base_url: "http://localhost:9292") }

end
