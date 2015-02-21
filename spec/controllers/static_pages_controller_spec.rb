require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
 
  describe "GET home" do
    before do
      @tweet = double(Tweet)
      @feed_items = double("Tweets")
      @user = double(User)
    end

    context "user is loged in" do
      before do
        allow(controller).to receive(:current_user) { @user }
        allow(@user).to receive(:logged_in?) { true }
        allow(@user).to receive_message_chain(:tweets, :build) { @tweet }
        allow(@user).to receive_message_chain(:feed, :paginate) { @feed_items }
      end

      it "checks if the user is logged in" do
        expect(@user.logged_in?).to eql(true)
      end

      it "returns HTTP success" do
        get :home
        expect(response).to have_http_status(:success)
      end

      it "assigns @tweet" do
        get :home
        expect(assigns(:tweet)).to eql(@tweet)
      end

      it "assigns @feed_items" do
        get :home
        expect(assigns(:feed_items)).to eql(@feed_items)
      end
    end

    context "User is not logged in" do
      before do
        allow(@user).to receive(:logged_in?) { false }
      end

      it "checks if the user is logged in" do
        expect(@user.logged_in?).to eql(false)
      end
    end

    it "renders the home page" do
      get :home
      expect(response).to render_template("home")
    end
  end

  describe "get about" do
    it "returns HTTP success" do
      get :about
      expect(response).to have_http_status(:success)
    end

    it "renders the help template" do
      get :about
      expect(response).to render_template("about")
    end
  end

  describe "get help" do
    it "returns HTTP success" do
      get :help
      expect(response).to have_http_status(:success)
    end

    it "renders the help template" do
      get :help
      expect(response).to render_template("help")
    end
  end

  describe "get contact" do
    it "returns HTTP success" do
      get :contact
      expect(response).to have_http_status(:success)
    end

    it "renders the contact template" do
      get :contact
      expect(response).to render_template("contact")
    end
  end
end
