require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shearches_index_url
    assert_response :success
  end

end
