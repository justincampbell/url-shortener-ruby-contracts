$: << File.expand_path('./lib')

require 'sinatra'
require 'shortener'

get '/' do
  redirect "https://github.com/justincampbell/url-shorteners"
end

get '/shorten' do
  url = params[:url]

  halt 400 unless url

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
