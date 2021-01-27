require 'rails_helper'

RSpec.describe "Carts", type: :request do

  describe "GET /update" do
    it "returns http success" do
      get "/carts/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/carts/show"
      expect(response).to have_http_status(:success)
    end
  end

end
