$: << File.expand_path('./lib')

require 'sinatra'
require 'shortener'

get '/' do
  redirect "https://github.com/justincampbell/language-exploration"
end

get '/shorten' do
  url = params[:url]
  token = shortener.shorten(url)

  [201, "/#{token}"]
end

get '/:token' do |token|
  full_url = shortener.expand(token)

  halt 404 unless full_url

  redirect full_url
end

private

def shortener
  @shortener ||= Shortener.instance
end
