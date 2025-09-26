require "test_helper"

class BacklogItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backlog_items_index_url
    assert_response :success
  end

  test "should get create" do
    get backlog_items_create_url
    assert_response :success
  end

  test "should get update" do
    get backlog_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get backlog_items_destroy_url
    assert_response :success
  end
end
