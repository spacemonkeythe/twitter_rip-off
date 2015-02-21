require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET index" do
    include UsersHelper

    before do
      @user = double(User)
      @users = double("Users")

      allow(User).to receive(:all) { @users }
    end

    context "User is logged in" do
      before do
        allow(controller).to receive(:current_user) { @user }
        allow(User).to receive_message_chain(:limit, :page) { @users }
      end

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { true }
        expect(@user.logged_in?).to eql(true)
      end

      it "assigns @users" do
        get :index
        expect(assigns(:users)).to eql(@users)
      end

      it "returns HTTP status found" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it " renders index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    context "User is not logged in" do

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { false }
        expect(@user.logged_in?).to eql(false)
      end

      it "stores the location" do
        allow(controller).to receive(:store_location) { "some/path" }
        expect(controller.store_location).to eql("some/path")
      end
      
      it "flashes :success" do
        get :index
        expect(flash[:danger]).to eql("Please log in.")
      end

      it "redirects to login page" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

  end

  describe "GET new" do
    before do
      allow(User).to receive(:new) { @user }
    end

    it "returns HTTP succes" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns @user" do
      get :new
      expect(assigns(:user)).to eql(@user)
    end

    it "renders signup page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET show" do
    before do
      @user = double(User)
      @tweets = double("Tweets")
      allow(@user).to receive_message_chain(:tweets, :paginate) { @tweets }
      allow(User).to receive(:find) { @user }
      get :show, id: 1
    end

    it "returns HTTP succes" do
      expect(response).to have_http_status(:success)
    end

    it "assigns @user" do
      expect(assigns(:user)).to eql(@user)
    end

    it "assigns @tweets" do
      expect(assigns(:tweets)).to eql(@tweets)
    end

    it "renders show template" do
      expect(response).to render_template("show")
    end
  end

  describe "POST create" do
    before do
      @user = double(User, id: 1)
      allow(User).to receive(:new) { @user }
      @params = { name: "Test1", email: "test1@test.com", password: "testpassword1", password_confirmation: "testpassword1" }
    end

    it "saves a user" do
      expect(@user).to receive(:save)
      post :create, user: @params
    end

    context "saving user in the database is OK" do
      let(:session) { { user_id: 1 } }
      before do
        allow(@user).to receive(:save) { true }
        allow(controller).to receive(:log_in).with(@user) { session }

        allow(@user).to receive(:to_model) { @user }
        allow(@user).to receive(:persisted?) { true }
        allow(@user).to receive(:model_name) { @user }
        allow(@user).to receive(:singular_route_key) { "users" }

        post :create, :user => @params
      end

      it "log in user" do
        expect(controller.log_in(@user)).to eql(session)
      end

      it "assigns @user" do
        expect(assigns(:user)).to eql(@user)
      end

      it "flashes :success" do
        expect(flash[:success]).to eql("Welcome to the Twitter rip-off app!")
      end

      it "redirects to user profil page" do
        expect(response).to redirect_to(users_path(@user))
      end
    end

    context "saving user to the database is not OK" do
      before do
        allow(@user).to receive(:save) { false }
        post :create, user: @params
      end

      it "assigns @user" do
        expect(assigns(:user)).to eql(@user)
      end

      it "renders the signin page" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before do
      @user = double(User, id: 1)
    end

    context "User is loged in" do
      before do
        allow(controller).to receive(:current_user) { @user }
        allow(User).to receive(:find) { @user }
      end

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { true }
        expect(@user.logged_in?).to eql(true)
      end

      context "User is authorised" do
        before do
          allow(controller).to receive(:current_user?).with(@user) { true }
        end

        it "checks if the current user is the right one" do
          expect(controller.current_user?(@user)).to eql( true )
        end

        it "assigns @user" do
          get :edit, id: 1
          expect(assigns(:user)).to eql(@user)
        end

        it "renders user edit page" do
          get :edit, id: 1
          expect(response).to render_template("users/edit")
        end
      end

      context "User is not authorised" do
        before do
          allow(controller).to receive(:current_user?).with(@user) { false }
        end

        it "redirects to home page" do
          get :edit, id: 1
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "User is not loged in" do

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { false }
        expect(@user.logged_in?).to eql(false)
      end

      it "stores the location" do
        allow(controller).to receive(:store_location) { "some/path" }
        expect(controller.store_location).to eql("some/path")
      end
      
      it "flashes :success" do
        get :edit, id: 1
        expect(flash[:danger]).to eql("Please log in.")
      end

      it "redirects to login page" do
        get :edit, id: 1
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST update" do
    before do
      @user = double(User, id: 1)
      @params = { name: "Test1", email: "test1@test.com", password: "testpassword1", password_confirmation: "testpassword1" }
    end

    context "user is signed in" do
      before do
        allow(controller).to receive(:current_user) { @user }
        allow(User).to receive(:find) { @user }
      end

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { true }
        expect(@user.logged_in?).to eql(true)
      end

      context "User is authorised" do
        before do
          allow(controller).to receive(:current_user?).with(@user) { true }
          allow(@user).to receive(:update_attributes) { true }

          allow(@user).to receive(:to_model) { @user }
          allow(@user).to receive(:persisted?) { true }
          allow(@user).to receive(:model_name) { @user }
          allow(@user).to receive(:singular_route_key) { "users" }
        end

        it "checks for the current user" do
          post :update, id: 1, user: @params
          expect(controller.current_user?(@user)).to eql(true)
        end

        it "updates the user" do
          expect(@user).to receive(:update_attributes) { true }

          post :update, id: 1, user: @params
        end

        it "assigns @user" do
          post :update, id: 1, user: @params

          expect(assigns(:user)).to eql(@user)
        end

        it "flashes :success" do
          post :update, id: 1, user: @params

          expect(flash[:success]).to eql("Profile updated")
        end

        context "Parameter for User update are not OK" do
          before do
            allow(@user).to receive(:update_attributes) { false }
          end

          it "assigns @series" do
            post :update, user: @params, id: 1
            expect(assigns(:user)).to eql(@user)
          end

          it "renders the new template" do
            post :update, user: @params, id: 1
            expect(response).to render_template("edit")
          end
        end
      end

      context "User is not authorised" do
        before do
          allow(controller).to receive(:current_user?).with(@user) { false }
        end

        it "redirects to home page" do
          get :edit, id: 1
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @user = double(User, id: 1)
    end

    context "User is logged in" do
      before do
        allow(controller).to receive(:current_user) { @user }
        allow(User).to receive(:find) { @user }
        allow(@user).to receive(:destroy) { true }
      end

      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { true }
        expect(@user.logged_in?).to eql(true)
      end

      context "User is authorised" do
        before do
          allow(User).to receive(:find) { @user }
          allow(controller).to receive(:current_user?).with(@user) { true }
          allow(@user).to receive(:destroy) { true }
        end

        it "returns http found" do
          post :destroy, id: 1
          expect(response).to have_http_status(:found)
        end

        it "checks for the current user" do
          post :destroy, id: 1
          expect(controller.current_user?(@user)).to eql(true)
        end

        it "assigns @user" do
          post :destroy, id: 1
          expect(assigns(:user)).to eql(@user)
        end

        it "flashes notice message" do
          delete :destroy, id: 1
          expect(flash[:notice]).to eql("A user has been removed.")
        end

        it "redirects to home page" do
          delete :destroy, id: 1
          expect(response).to redirect_to(root_path)
        end
      end

      context "user is not authorised in" do
        before do
          allow(User).to receive(:find) { @user }
          allow(controller).to receive(:current_user?).with(@user) { false }
        end

        it "returns http found" do
          post :destroy, id: 1
          expect(response).to have_http_status(:found)
        end

        it "checks for the current user" do
          post :destroy, id: 1
          expect(controller.current_user?(@user)).to eql(false)
        end

        it "redirects to home page" do
          post :destroy, id: 1
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "User is not loged in" do
      
      it "checks if the user is loged in" do
        allow(@user).to receive(:logged_in?) { false }
        expect(@user.logged_in?).to eql(false)
      end

      it "stores the location" do
        allow(controller).to receive(:store_location) { "some/path" }
        expect(controller.store_location).to eql("some/path")
      end
      
      it "flashes :success" do
        get :edit, id: 1
        expect(flash[:danger]).to eql("Please log in.")
      end

      it "redirects to login page" do
        get :edit, id: 1
        expect(response).to redirect_to(login_path)
      end
    end
  end

end
