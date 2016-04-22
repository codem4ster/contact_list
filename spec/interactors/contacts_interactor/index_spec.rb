require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'index' do

    let!(:contacts) { Fabricate.times(45, :contact) }

    context 'when parameters valid' do
      let(:first_ten) { contacts.take(10) }
      let(:args) { {page: 1} }
      subject(:context) { ContactsInteractor::Index.call args }
      it "gets the first page" do
        expect(context.contacts.map(&:name)).to eq first_ten.map(&:name)
        expect(context.pagination.total_pages).not_to be nil
        expect(context.pagination).to be_decorated
        expect(context.contacts).to be_decorated
      end
    end

    context 'when page is not valid' do
      let(:args) { {page: 'a'} }
      subject(:context) { ContactsInteractor::Index.call args }
      it 'fails with invalid page error' do
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Page parameter is invalid'
      end
    end

  end
end