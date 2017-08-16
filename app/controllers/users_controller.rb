class UsersController < ApplicationController

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end

end
