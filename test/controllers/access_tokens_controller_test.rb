require 'test_helper'

class AccessTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get access_tokens_create_url
    assert_response :success
  end

end
