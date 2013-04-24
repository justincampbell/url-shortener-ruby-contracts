$: << File.expand_path('./lib')

require 'sinatra'
require 'shortener'

get '/' do
  redirect "https://github.com/justincampbell/language-exploration"
end
