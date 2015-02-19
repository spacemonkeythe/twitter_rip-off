require 'rails_helper'

RSpec.describe Admin::UsersController, :type => :controller do

    before do
      @user = double(User)

      allow(controller).to receive(:current_user) { @user }
    end

  context "User is admin" do
    before do
      allow(@user).to receive(:admin?) { true }
    end

    it "checks if the user is admin" do
      expect(@user.admin?).to eql(true)
    end

    describe "GET index" do

      before do
        @users = double("Users")

        allow(User).to receive_message_chain(:limit, :page) { @users }

        get :index
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

    describe "GET edit" do
      before do
        allow(User).to receive(:find) { @user }

        get :edit, id: 1
      end


      it "returns HTTP success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @user" do
        expect(assigns(:user)).to eql(@user)
      end

      it "renders the admin/users/edit template" do
        expect(response).to render_template("admin/users/edit")
      end
    end

    describe "POST update" do
      before do
        allow(User).to receive(:find) { @user }
        allow(@user).to receive(:update)

        @params = { name: "Test1", email: "test1@test.com", password: "testpassword1", password_confirmation: "testpassword1" }
      end

      it "updates a user" do
        expect(@user).to receive(:update)
        post :update, user: @params, id: 1
      end

      context "updating user params in the database are Ok" do
        before do
          allow(@user).to receive(:update) { true }
          post :update, user: @params, id: 1
        end

        it "redirects to admin_user show" do
          expect(response).to redirect_to(admin_user_path(@user))
        end
      end

      context "updating the user is not OK" do

        before do
          allow(@user).to receive(:update) { false }
        end

        it "assigns @series" do
          post :update, user: @params, id: 1
          expect(assigns(:user)).to eql(@user)
        end

        it "renders the new template" do
          post :update, user: @params, id: 1
          expect(response).to render_template("admin/users/edit")
        end
      end
    end

    describe "DELETE destroy" do
      before do
        allow(User).to receive(:find) { @user }
        allow(@user).to receive(:destroy) { true }
      end
      it "returns http found" do
        post :destroy, id: 1
        expect(response).to have_http_status(:found)
      end

      it "assigns @user" do
        post :destroy, id: 1
        expect(assigns(:user)).to eql(@user)
      end

      it "display the notice" do
        post :destroy, id: 1
        expect(flash[:notice]).to eql("A user has been removed.")
      end

      it "renders the admin_index page" do
        post :destroy, id: 1
        expect(response).to redirect_to(admin_users_path)
      end
    end
  end

  context "User is not admin" do
    before do
      allow(@user).to receive(:admin?) { false }
    end

    it "checks if the user is admin" do
      expect(@user.admin?).to eql(false)
    end

    describe "GET index" do
      context "GET index" do
        before do
          get :index
        end
      end

      context "GET show" do
        before do
          get :show, id: 1
        end
      end

      context "GET edit" do
        before do
          get :edit, id: 1
        end
      end

      context "POST edit" do
        before do
          post :update, user: @params, id: 1
        end
      end

      context "DELETE destroy" do
        before do
          post :destroy, id: 1
        end
      end

      after(:each) do
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
