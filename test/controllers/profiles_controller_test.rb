require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shearches_index_url
    assert_response :success
  end

end
