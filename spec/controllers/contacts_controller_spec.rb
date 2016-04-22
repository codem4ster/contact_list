require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe "POST #create" do
    context 'on successfull request' do
      let(:args) do
        { contact: {
            name: 'onur',
            last_name: 'elibol',
            phone: '+90 555 1111111' } }
      end
      it "returns http success" do
        post :create, args
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('create_contact_success')
      end
    end

    context 'on failed request' do
      let(:args) do
        { contact: {
            name: 'onur',
            last_name: 'elibol',
            phone: '+90 5551111111' } }
      end
      it "returns http fail" do
        post :create, args
        expect(response).to have_http_status(400)
        expect(response).to match_response_schema('request_fail')
      end
    end
  end

  describe "POST #update" do
    context 'on successfull request' do
      let!(:contact) { Fabricate(:contact) }
      let(:args) do
        { id: contact.id,
          contact: {
            phone: '+90 555 1111111' } }
      end
      it "returns http success" do
        post :update, args
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('update_contact_success')
      end
    end

    context 'on bad request' do
      let!(:contact) { Fabricate(:contact) }
      let(:args) do
        { id: contact.id,
          contact: {
            phone: '+90 5551111111' } }
      end
      it "returns bad request error" do
        post :update, args
        expect(response).to have_http_status(400)
        expect(response).to match_response_schema('request_fail')
      end
    end

    context 'on contact not found' do
      let(:args) do
        { id: 99,
          contact: {
            phone: '+90 555 1111111' } }
      end
      it "returns not found error" do
        post :update, args
        expect(response).to have_http_status(404)
        expect(response).to match_response_schema('request_fail')
      end
    end
  end

  describe "GET #index" do
    context 'on successfull request' do
      let!(:contacts) { Fabricate.times(15, :contact) }
      let(:args) { { page: 1 } }
      it "returns http success" do
        get :index, args
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('index_contact_success')
      end
    end

    context 'on bad request' do
      let(:args) { { page: -2.67 } }
      it "returns bad request error" do
        get :index, args
        expect(response).to have_http_status(400)
        expect(response).to match_response_schema('request_fail')
      end
    end
  end

  describe "GET #show" do
    context 'on successfull request' do
      let!(:contact) { Fabricate(:contact) }
      let(:args) { { id: contact.id } }
      it "returns http success" do
        get :show, args
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('show_contact_success')
      end
    end

    context 'on contact not found' do
      let(:args) do
        { id: 99 }
      end
      it "returns not found error" do
        get :show, args
        expect(response).to have_http_status(404)
        expect(response).to match_response_schema('request_fail')
      end
    end
  end

  describe "DELETE #destroy" do
    context 'on successfull request' do
      let!(:contact) { Fabricate(:contact) }
      let(:args) { { id: contact.id } }
      it "returns http success" do
        delete :destroy, args
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('destroy_contact_success')
      end
    end

    context 'on contact not found' do
      let(:args) do
        { id: 99 }
      end
      it "returns not found error" do
        delete :destroy, args
        expect(response).to have_http_status(404)
        expect(response).to match_response_schema('request_fail')
      end
    end
  end

end
