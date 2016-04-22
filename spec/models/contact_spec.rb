require 'rails_helper'

RSpec.describe XmlContactImporter, type: :model do

  describe '#import' do

    context 'when structure true' do
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
      subject { XmlContactImporter.new(content) }
      it 'imports data from xml' do
        subject.import
        expect(subject.total).to eq 3
        expect(subject.imported).to eq 3
        expect(subject.not_imported).to eq 0
        expect(Contact.where(name: 'Hamma').count).to eq 1
      end
    end

    context 'when structure erronous' do
      let(:content) { '<?xml version="1.0" encoding="UTF-8" ?><comtacts></comtacts>' }
      subject { XmlContactImporter.new(content) }
      it 'raises structure error' do
        expect { subject.import }.to raise_error ContactImporterException
      end
    end

    context 'when some data cannot be imported' do
      let(:content) do
        <<-content.strip_heredoc
          <?xml version="1.0" encoding="UTF-8" ?>
          <contacts>
            <contact><name>Kökten</name><lastName>Adal</lastName><phone>+90 3338859342</phone></contact>
            <contact><name>Hamma</name><lastName>Abdurrezak</lastName><phone>+90 333 1563682</phone></contact>
            <contact><name>Güleycan</name><lastName>Şensal</lastName><phone>+90 333 2557114</phone></contact>
          </contacts>
        content
      end
      subject { XmlContactImporter.new(content) }
      it 'imports importable data from xml' do
        subject.import
        expect(subject.total).to eq 3
        expect(subject.imported).to eq 2
        expect(subject.not_imported).to eq 1
        expect(Contact.where(name: 'Hamma').count).to eq 1
        expect(Contact.where(name: 'Kökten').count).to eq 0
      end
    end


  end

end
