require "test_helper"

class BacklogItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @game = games(:one)
    @backlog_item = backlog_items(:one)

    # Log in the user before every test
    post session_url, params: { email_address: @user.email_address, password: "secret" }
    follow_redirect! if response.redirect?
  end

  test "should get index" do
    get backlog_items_url
    assert_response :success
  end

  test "should create backlog_item" do
    assert_difference("BacklogItem.count") do
      post backlog_items_url, params: { igdb_id: games(:three).igdb_id }
    end
    assert_redirected_to backlog_items_url
  end

  test "should update backlog_item" do
    patch backlog_item_url(@backlog_item), params: { backlog_item: { status: "completed" } }
    assert_redirected_to backlog_items_url
  end

  test "should destroy backlog_item" do
    assert_difference("BacklogItem.count", -1) do
      delete backlog_item_url(@backlog_item)
    end
    assert_redirected_to backlog_items_url
  end
end
