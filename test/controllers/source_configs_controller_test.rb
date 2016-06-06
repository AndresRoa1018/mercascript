require 'test_helper'

class SourceConfigsControllerTest < ActionController::TestCase
  setup do
    @source_config = source_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_config" do
    assert_difference('SourceConfig.count') do
      post :create, source_config: { active: @source_config.active, data: @source_config.data, datasource: @source_config.datasource, domain: @source_config.domain, login: @source_config.login, password: @source_config.password }
    end

    assert_redirected_to source_config_path(assigns(:source_config))
  end

  test "should show source_config" do
    get :show, id: @source_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_config
    assert_response :success
  end

  test "should update source_config" do
    patch :update, id: @source_config, source_config: { active: @source_config.active, data: @source_config.data, datasource: @source_config.datasource, domain: @source_config.domain, login: @source_config.login, password: @source_config.password }
    assert_redirected_to source_config_path(assigns(:source_config))
  end

  test "should destroy source_config" do
    assert_difference('SourceConfig.count', -1) do
      delete :destroy, id: @source_config
    end

    assert_redirected_to source_configs_path
  end
end
