require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'show' do

    let!(:contact) { Fabricate.times(10, :contact).sample }
    context 'when id supplied' do
      let(:args) { {id: contact.id} }
      subject(:context) { ContactsInteractor::Show.call args }
      it "gets the related contact" do
        expect(context.success?).to be true
        expect(context.contact.name).to eq contact.name
        expect(context.contact.last_name).to eq contact.last_name
        expect(context.contact.phone).to eq contact.phone
        expect(context.contact).to be_decorated
      end
    end

    context 'when id invalid' do
      let(:args) { {id: 'unknown'} }
      subject(:context) { ContactsInteractor::Show.call args }
      it "fails with id invalid error" do
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Contact not found with id: unknown'
      end
    end


  end

end
