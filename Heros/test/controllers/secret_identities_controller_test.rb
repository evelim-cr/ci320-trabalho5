require 'test_helper'

class SecretIdentitiesControllerTest < ActionController::TestCase
  setup do
    @secret_identity = secret_identities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secret_identities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secret_identity" do
    assert_difference('SecretIdentity.count') do
      post :create, secret_identity: { address: @secret_identity.address, hero_id: @secret_identity.hero_id, name: @secret_identity.name, ocupation: @secret_identity.ocupation }
    end

    assert_redirected_to secret_identity_path(assigns(:secret_identity))
  end

  test "should show secret_identity" do
    get :show, id: @secret_identity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secret_identity
    assert_response :success
  end

  test "should update secret_identity" do
    patch :update, id: @secret_identity, secret_identity: { address: @secret_identity.address, hero_id: @secret_identity.hero_id, name: @secret_identity.name, ocupation: @secret_identity.ocupation }
    assert_redirected_to secret_identity_path(assigns(:secret_identity))
  end

  test "should destroy secret_identity" do
    assert_difference('SecretIdentity.count', -1) do
      delete :destroy, id: @secret_identity
    end

    assert_redirected_to secret_identities_path
  end
end
