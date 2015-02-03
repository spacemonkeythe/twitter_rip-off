require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET home" do
    it "returns HTTP success" do
      get :home
      expect(response).to have_http_status(:success)
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
