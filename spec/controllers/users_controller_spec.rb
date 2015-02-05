require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET new" do

    it "returns HTTP succes" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders signup page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET show" do
    before do
      @user = double(User)
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
      before do
        allow(@user).to receive(:save) { true }

        allow(@user).to receive(:to_model) { @user }
        allow(@user).to receive(:persisted?) { true }
        allow(@user).to receive(:model_name) { @user }
        allow(@user).to receive(:singular_route_key) { "users" }

        post :create, user: @params
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

end
