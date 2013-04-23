require './test/test_helper'

describe "/" do
  before { get '/' }

  it "redirects to github" do
    assert_equal 302, last_response.status
    assert_equal "https://github.com/justincampbell/language-exploration",
      last_response.header['Location']
  end
end
