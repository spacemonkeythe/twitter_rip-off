require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
    
    it "returns HTTP succes" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the sign up template" do
      get :new
      expect(response).to render_template("sessions/new")
    end
  end

  describe "POST create" do
    include SessionsHelper

    before do 
      @user = double(User, id: 1)
      @params = { email: "test1@test.com", password: "testpassword1" } 
      post :create, session: @params
    end

    context "User exists and it provided valid credentials" do
      before do
        allow(User).to receive(:find_by) { @user }
        allow(@user).to receive(:authenticate) { true }
      end

      it "finds and autheticate user" do
        expect(@user && @user.authenticate).to be_truthy
      end

      it "logs in user" do
        expect(log_in @user).to eql(1)
      end

      context "User is checked 'Rememeber me'" do
        let(:params) { { session: { remember_me: "1" } } }

        it "remembers user" do
          expect(params[:session][:remember_me]).to be_truthy

          allow(@user).to receive(:remember)
          allow(@user).to receive(:id)
          allow(@user).to receive(:remember_token) { "remembertoken" }

          expect(remember @user).to eql("remembertoken")
        end
      end

      context "User did not checked 'Remember me'" do
        let(:params) { { session: { remember_me: nil } } }

        it "forgets user" do
          expect(params[:session][:remember_me]).to be_falsey

          allow(@user).to receive(:forget)

          expect(forget @user)
        end
      end
    end

    context "User don't exists or it didn't provide valid credentials" do
      before do
        allow(User).to receive(:find_by) { @user }
        allow(@user).to receive(:authenticate) { false }
      end

      it "finds and autheticate user" do
        expect(@user && @user.authenticate).to be_falsey
      end

      it "displays the notice" do
        expect(flash.now[:danger]).to eql("Invalid email/password combination")
      end

      it "renders the new template" do
        expect(response).to render_template("sessions/new")
      end

    end

  end

  describe "POST delete" do
    before do
      @user = double(User)
    end

    context "User is loged in" do
      before do
        allow(@user).to receive(:logged_in?) { true }
      end

      it "logout user" do
        allow(@user).to receive(:log_out)
        expect(@user.log_out).to be_nil
        post :destroy
      end
    end

    it "redirecrts to home page" do
      post :destroy
      expect(response).to have_http_status(:found)
    end
  end

end
