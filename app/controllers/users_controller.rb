class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @court_items = current_user.court_items
  end
end
