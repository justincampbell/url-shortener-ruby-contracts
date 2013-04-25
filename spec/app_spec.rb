require './spec/spec_helper'

describe "/" do
  before { get "/" }

  it "redirects to github" do
    assert_equal 302, last_response.status
    assert_equal "https://github.com/justincampbell/language-exploration",
      last_response.header['Location']
  end
end

describe "/shorten" do
  before { get path }

  let(:path) { "/shorten?url=#{url}" }
  let(:url) { "http://justincampbell.me" }

  it "returns created with a token as a path" do
    token = shortener.send(:urls).keys.last

    assert_equal 201, last_response.status
    assert_equal "/#{token}", last_response.body
  end

  describe "with no url" do
    let(:path) { "/shorten" }

    it "respends with bad request" do
      assert_equal 400, last_response.status
    end
  end
end

describe "/:token" do
  before { get "/#{token}" }

  let(:token) { shortener.shorten(url) }
  let(:url) { "http://justincampbell.me" }

  it "redirects to the url" do
    assert_equal 302, last_response.status
    assert_equal url, last_response.header['Location']
  end

  describe "when a token does not exist" do
    let(:token) { "nonexistant" }

    it "responds with not found" do
      assert_equal 404, last_response.status
    end
  end
end
