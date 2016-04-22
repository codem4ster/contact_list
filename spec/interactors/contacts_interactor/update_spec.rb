require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'update' do

    let(:contact) { Fabricate(:contact) }

    context 'when parameters valid' do
      let(:args) do
        { id: contact.id,
          name: 'onur',
          phone: '+90 555 1111111' }
      end
      subject!(:context) { ContactsInteractor::Update.call args }
      it 'updates contact' do
        found = Contact.find_by_id(contact.id)
        expect(found).not_to be nil
        expect(context.success?).to be true
        expect(contact.id).to eq args[:id]
        expect(found.name).to eq args[:name]
        expect(found.phone).to eq args[:phone]
        expect(found.last_name).to eq contact.last_name
      end
    end

    context 'when phone invalid' do
      let(:args) do
        { id: contact.id,
          phone: '+905551111111' }
      end
      subject!(:context) { ContactsInteractor::Update.call args }
      it 'fails with phone invalid error' do
        found = Contact.find_by_id(contact.id)
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Phone is invalid'
        expect(found.phone).to eq contact.phone
        expect(context.status).to eq 400
      end
    end

    context 'when record not found' do
      let(:args) do
        { id: 987,
          phone: '+90 555 1111111' }
      end
      subject!(:context) { ContactsInteractor::Update.call args }
      it 'fails with record not found error' do
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Contact not found with id: 987'
        expect(context.status).to eq 404
      end
    end
  end

end

