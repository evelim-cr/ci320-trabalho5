require 'test_helper'

class ComicsHerosControllerTest < ActionController::TestCase
  setup do
    @comics_hero = comics_heros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comics_heros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comics_hero" do
    assert_difference('ComicsHero.count') do
      post :create, comics_hero: { comic_id: @comics_hero.comic_id, hero_id: @comics_hero.hero_id }
    end

    assert_redirected_to comics_hero_path(assigns(:comics_hero))
  end

  test "should show comics_hero" do
    get :show, id: @comics_hero
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comics_hero
    assert_response :success
  end

  test "should update comics_hero" do
    patch :update, id: @comics_hero, comics_hero: { comic_id: @comics_hero.comic_id, hero_id: @comics_hero.hero_id }
    assert_redirected_to comics_hero_path(assigns(:comics_hero))
  end

  test "should destroy comics_hero" do
    assert_difference('ComicsHero.count', -1) do
      delete :destroy, id: @comics_hero
    end

    assert_redirected_to comics_heros_path
  end
end
