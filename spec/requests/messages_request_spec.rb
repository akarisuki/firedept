require 'rails_helper'

RSpec.describe "Messages", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/messages/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/messages/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/messages/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/messages/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
