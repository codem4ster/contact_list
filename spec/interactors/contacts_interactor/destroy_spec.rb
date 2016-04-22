require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'destroy' do

    let!(:contact) { Fabricate.times(10, :contact).sample }
    context 'when id supplied' do
      let(:args) { {id: contact.id} }
      subject!(:context) { ContactsInteractor::Destroy.call args }
      it "deletes contact" do
        found = Contact.where(id: contact.id).first
        expect(context.success?).to be true
        expect(found).to be nil
      end
    end

    context 'when id invalid' do
      let(:args) { {id: 'unknown'} }
      subject(:context) { ContactsInteractor::Destroy.call args }
      it "fails with id invalid error" do
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Contact not found with id: unknown'
      end
    end


  end

end