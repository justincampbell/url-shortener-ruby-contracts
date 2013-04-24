require './spec/spec_helper.rb'

describe Shortener do
  let(:shortener) { Shortener.new }
  let(:url) { "http://justincampbell.me" }

  it "shortens and expands a url" do
    token = shortener.shorten(url)
    full_url = shortener.expand(token)

    refute_equal token, full_url
    assert_equal url, full_url
  end
end
