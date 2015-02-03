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
      @user = double(User);
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

end
