class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  def show
    @product_count = Product.all.length
    @category_count = Category.all.length
  end
end
