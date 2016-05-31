require 'test_helper'

class ResultProductsControllerTest < ActionController::TestCase
  setup do
    @result_product = result_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:result_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result_product" do
    assert_difference('ResultProduct.count') do
      post :create, result_product: { description_html: @result_product.description_html, name: @result_product.name, nick_seller: @result_product.nick_seller, price: @result_product.price, sold: @result_product.sold, type: @result_product.type, url: @result_product.url }
    end

    assert_redirected_to result_product_path(assigns(:result_product))
  end

  test "should show result_product" do
    get :show, id: @result_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result_product
    assert_response :success
  end

  test "should update result_product" do
    patch :update, id: @result_product, result_product: { description_html: @result_product.description_html, name: @result_product.name, nick_seller: @result_product.nick_seller, price: @result_product.price, sold: @result_product.sold, type: @result_product.type, url: @result_product.url }
    assert_redirected_to result_product_path(assigns(:result_product))
  end

  test "should destroy result_product" do
    assert_difference('ResultProduct.count', -1) do
      delete :destroy, id: @result_product
    end

    assert_redirected_to result_products_path
  end
end
