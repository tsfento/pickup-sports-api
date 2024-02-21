require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profiles/:username" do
    let(:user) {create(:user)}
    let(:token) {auth_token_for_user(user)}
    

    it "returns http success" do
      get "/profiles/#{user.username}", headers: {Authorization: "Bearer #{token}"}
      expect(response).to have_http_status(:success)
    end
  end

end
