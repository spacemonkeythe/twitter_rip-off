require 'rails_helper'

RSpec.describe TweetsController, :type => :controller do
  before do
    @tweet = double(Tweet, id: 1)
    @user = double(User)
    @params = { content: "This is the tweet's content" }
  end

  context "user is logged in" do
    before do
      allow(controller).to receive(:current_user) { @user }
      allow(@user).to receive(:logged_in?) { true }
    end

    it "checks if the user is loged in" do
      expect(@user.logged_in?).to eql(true)
    end

    describe "POST create" do
      before do
        allow(@user).to receive_message_chain(:tweets, :build) { @tweet }
      end

      it "saves the tweet" do
        expect(@tweet).to receive(:save)
        post :create, tweet: @params
      end

      context "saving tweet in the database is OK" do
        before do
          allow(@tweet).to receive(:save) { true }
          post :create, tweet: @params
        end

        it "assigns @tweet" do
          expect(assigns(:tweet)).to eql(@tweet)
        end

        it "flashes success" do
          expect(flash[:success]).to eql("Tweet created!")
        end

        it "redirects to root path" do
          expect(response).to redirect_to(root_path)
        end
      end

      context "saving tweet in the database is not OK" do
        before do
          allow(@tweet).to receive(:save) { false }
          @feed_items = double(Array)
          post :create, tweet: @params
        end

        it "assigns empty @feed_items instance" do
          expect(assigns(:feed_items)).to eql([])
        end

        it "renders the home page" do
          expect(response).to render_template("static_pages/home")
        end
      end
    end

    context "@tweet is found" do
      before do
        allow(@tweet).to receive(:nil?) { false }
        allow(@user).to receive_message_chain(:tweets, :find_by) { @tweet }
      end

      it "finds the tweet" do
        expect(@user.tweets.find_by).to eql(@tweet)
        expect(@tweet).not_to eql(:nil)
      end

      describe "DELETE destroy" do
        before do
          allow(@tweet).to receive(:destroy) { true }
          post :destroy, id: 1
        end

        it "assigns @tweet" do
          expect(assigns(:tweet)).to eql(@tweet)
        end

        it "destroys the tweet" do
          expect(@tweet.destroy).to eql(true)
        end

        it "flashes notice message" do
          expect(flash[:success]).to eql("Tweet deleted")
        end

        it "redirects to home page" do
          expect(response).to redirect_to(root_path)
        end
      end

      context "tweet is not found" do
        before do
          allow(@tweet).to receive(:nil?) { true }
          post :destroy, id: 1
        end

        it "redirects to home page" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  context "user is not loged in" do
    before do
      allow(@user).to receive(:logged_in?) { false }
      allow(controller).to receive(:store_location) { "some/path" }
    end

    it "checks if the user is loged in" do
      expect(@user.logged_in?).to eql(false)
    end

    it "stores the location" do
      expect(controller.store_location).to eql("some/path")
    end

    context "DELETE destroy" do
    
      it "flashes :success" do
        delete :destroy, id: 1
        expect(flash[:danger]).to eql("Please log in.")
      end

      it "redirects to login page" do
        delete :destroy, id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    context "POST update" do
    
      it "flashes :success" do
        post :create
        expect(flash[:danger]).to eql("Please log in.")
      end

      it "redirects to login page" do
        post :create
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
