require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'create' do

    context 'when parameters valid' do
      let(:args) do
        { name: 'onur',
          last_name: 'elibol',
          phone: '+90 555 1111111' }
      end
      subject(:context) { ContactsInteractor::Create.call args }
      it 'creates contact' do
        expect(context.success?).to be true
        expect(context.contact.id).not_to be nil
      end
    end

    context 'when name missing' do
      let(:args) do
        { name: nil,
          last_name: 'elibol',
          phone: '+90 555 1111111' }
      end
      subject(:context) { ContactsInteractor::Create.call args }
      it 'warns with name missing' do
        expect(context.success?).to be false
        expect(context.contact).to be nil
        expect(context.errors[0]).to eq "Name can't be blank"
      end
    end

    context 'when last_name missing' do
      let(:args) do
        { name: 'onur',
          last_name: nil,
          phone: '+90 555 1111111' }
      end
      subject(:context) { ContactsInteractor::Create.call args }
      it 'warns with last name missing' do
        expect(context.success?).to be false
        expect(context.contact).to be nil
        expect(context.errors[0]).to eq "Last name can't be blank"
      end
    end

    context 'when phone_number missing' do
      let(:args) do
        { name: 'onur',
          last_name: 'elibol',
          phone: nil }
      end
      subject(:context) { ContactsInteractor::Create.call args }
      it 'warns with last name missing' do
        expect(context.success?).to be false
        expect(context.contact).to be nil
        expect(context.errors[0]).to eq "Phone can't be blank"
      end
    end

    context "when phone number doesn't match the rule" do
      let(:args) do
        { name: 'onur',
          last_name: 'elibol',
          phone: '+90555 1111111' }
      end
      subject(:context) { ContactsInteractor::Create.call args }
      it 'warns with last name missing' do
        expect(context.success?).to be false
        expect(context.contact).to be nil
        expect(context.errors[0]).to eq "Phone is invalid"
      end
    end

  end

end