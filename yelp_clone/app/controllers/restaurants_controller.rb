class RestaurantsController < ApplicationController
  def index
    raise 'Hello from the index action'
  end
  def show
    render 'index'
  end
end
