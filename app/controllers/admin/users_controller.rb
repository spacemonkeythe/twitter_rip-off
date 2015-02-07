class Admin::UsersController < ApplicationController
  before_action :correct_user

  def index 
    @users = User.paginate(per_page: 5, page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render "admin/users/edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "A user has been removed."
    redirect_to admin_users_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_token)
  end

  def correct_user
    redirect_to(root_url) unless current_user.admin?
  end
end
