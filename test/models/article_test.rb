require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @article = @user.articles.build(title: "test article", body: "this is test.", is_visible: true)
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "user_id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "title should be present" do
    @article.title = "      "
    assert_not @article.valid?
  end

  test "title should not be too long" do
    @article.title = "a" * 51
    assert_not @article.valid?
  end

  test "body should be present" do
    @article.body = "         "
    assert_not @article.valid?
  end

  test "body should not be too long" do
    @article.body = "a" * 10001
    assert_not @article.valid?
  end

  test "is visible should be true or false" do
    @article.is_visible = nil
    assert_not @article.valid?
    @article.is_visible = false
    assert @article.valid?
  end
end
