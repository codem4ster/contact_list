require 'rails_helper'

RSpec.describe ContactsInteractor, type: :interactor do

  describe 'import_with_string' do

    context 'when successfull' do
      let(:content) do
        <<-content.strip_heredoc
          <?xml version="1.0" encoding="UTF-8" ?>
          <contacts>
            <contact><name>Kökten</name><lastName>Adal</lastName><phone>+90 333 8859342</phone></contact>
            <contact><name>Hamma</name><lastName>Abdurrezak</lastName><phone>+90 333 1563682</phone></contact>
            <contact><name>Güleycan</name><lastName>Şensal</lastName><phone>+90 333 2557114</phone></contact>
          </contacts>
        content
      end
      let(:importer) { XmlContactImporter }
      let(:args) { {content: content, importer: importer} }
      subject!(:context) { ContactsInteractor::ImportWithString.call args }
      it "import contacts" do
        expect(context.success?).to be true
        expect(context.total).to be 3
        expect(context.imported).to be 3
        expect(context.not_imported).to be 0
      end
    end

    context 'content invalid' do
      let(:content) { '<?xml version="1.0" encoding="UTF-8" ?><comtacts></comtacts>' }
      let(:importer) { XmlContactImporter }
      let(:args) { {content: content, importer: importer} }
      subject!(:context) { ContactsInteractor::ImportWithString.call args }
      it "fails with error" do
        expect(context.success?).to be false
        expect(context.errors[0]).to eq 'Check your xml structure'
      end
    end


  end

end