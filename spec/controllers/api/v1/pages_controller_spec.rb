require 'rails_helper'

describe Api::V1::PagesController do

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :page }
      get :index
    end

    it "returns 4 records from the database" do
      page_response = JSON.parse(response.body, symbolize_names: true)
      expect(page_response).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe 'POST #get_data' do

    context "when successfully fetched page content" do
      before(:each) do
        post :get_data, url: "http://google.com"
      end

      it 'should increase page count by 1' do
        page_response = JSON.parse(response.body, symbolize_names: true)
        expect(page_response[:url]).to eql "http://google.com"
      end

      it { should respond_with 200 }
    end

    context "when parameter is invalid" do
      before(:each) do
        post :get_data
      end
      
      it 'renders an error json' do
        page_response = JSON.parse(response.body, symbolize_names: true)
        expect(page_response).to have_key(:error)
      end

      it { should respond_with 400 }
    end
  end
end