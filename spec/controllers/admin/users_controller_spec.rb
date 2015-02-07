require 'rails_helper'

RSpec.describe Admin::UsersController, :type => :controller do

  context "User is admin" do
    describe "GET index" do

      before do
        @user = double(User)
        @users = double("Users")

        allow(User).to receive_message_chain(:limit, :page) { @users }
        allow(controller).to receive(:current_user) { @user }
        allow(@user).to receive(:admin?) { true }

        get :index
      end

      it "checks if the user is admin" do
        expect(@user.admin?).to eql(true)
      end

      it "assigns @users" do
        expect(assigns(:users)).to eql(@users)
      end

      it "returns HTTP status found" do
        expect(response).to have_http_status(:success)
      end

      it " renders index template" do
        expect(response).to render_template("admin/users/index")
      end
    end

    describe "GET show" do
      before do
        @user = double(User)
        allow(controller).to receive(:current_user) { @user }
        allow(@user).to receive(:admin?) { true }
        allow(User).to receive(:find) { @user }
        get :show, id: 1
      end

      it "returns HTTP succes" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @user" do
        expect(assigns(:user)).to eql(@user)
      end

      it "renders show template" do
        expect(response).to render_template("admin/users/show")
      end
    end
  end
  context "User is not admin" do
  before do
    allow(controller).to receive(:current_user) { @user }
    allow(@user).to receive(:admin?) { false }
    get :index
  end

  it "checks if the user is admin" do
    expect(@user.admin?).to eql(false)
  end

  it "redirects to login page" do
    expect(response).to redirect_to(root_path)
  end
end

end
