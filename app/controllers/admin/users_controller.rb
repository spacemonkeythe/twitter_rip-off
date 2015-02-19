class Admin::UsersController < ApplicationController
  before_action :correct_user
  before_action :find_user, except: [:index]

  def index 
    @users = User.paginate(per_page: 5, page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render "admin/users/edit"
    end
  end

  def destroy
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

  def find_user
    @user = User.find(params[:id])
  end
end
