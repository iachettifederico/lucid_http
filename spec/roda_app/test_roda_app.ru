require 'roda'
Roda.plugin :json
Roda.route do |r|
  r.get('hello'){"<h1>Hello World!</h1>"}
  r.get('hello/you'){"<h1>Hello, You!</h1>"}
  r.get('hello_world'){'You said: hello_world'}
  r.get('hello_world.json') do
    {
      content: "You said: hello_world",
      keyword: "hello_world",
      timestamp: "2016-12-31 15:00:42 -0300",
      method: "GET",
      status: 200
    }
  end
  r.get('redirection'){"You have arrived here due to a redirection."}
  r.get(%w"over_there redirect_me"){r.redirect '/redirection'}
  r.is('verb'){"<#{r.request_method}>"}
  r.post(%w'receive params'){r.params}
  r.get('403') do
    response.status = 403
    "The request returned a 403 status."
  end
  r.get('500') do
    raise ArgumentError, "wrong number of arguments (given 0, expected 2+)"
  end
  r.get('not_500'){""}
end
run Roda
