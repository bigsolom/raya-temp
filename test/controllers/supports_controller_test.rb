require 'test_helper'

class SupportsControllerTest < ActionController::TestCase
  test "should get support" do
    get :support
    assert_response :success
  end

end
