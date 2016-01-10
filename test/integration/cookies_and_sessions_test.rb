require 'test_helper'
require 'rack/test'

describe 'Cookies and sessions application' do
  include Rack::Test::Methods

  def app
    CookiesAndSessions::Application.new
  end

  def response
    last_response
  end

  it 'passes action inside the Rack env' do
    get '/', {}, 'HTTP_ACCEPT' => 'text/html'

    set_cookie_value = response.headers["Set-Cookie"]
    rack_session = /(rack.session=.+);/i.match(set_cookie_value).captures.first.gsub("; path=/", "")

    get '/', {}, {'HTTP_ACCEPT' => 'text/html', 'Cookie' => rack_session}

    response.headers["Set-Cookie"].must_be_nil
  end
end
