class XmlContactImporter < ContactImporter

  def import
    contacts_hash = Hash.from_xml @content
    if contacts_hash['contacts'] and contacts_hash['contacts']['contact']
      contacts = contacts_hash['contacts']['contact']
      @total = contacts.size
      contacts.each do |contact_hash|
        contact_hash['last_name'] = contact_hash['lastName']
        contact_hash.delete 'lastName'
        import_contact(contact_hash)
      end
    else
      raise ContactImporterException, 'Check your xml structure'
    end
  end

  def import_contact(contact_hash)
    contact = Contact.new(contact_hash)
    contact.save!
    @imported += 1
  rescue ActiveRecord::RecordInvalid => e
    @not_imported += 1
    # Rails.logger.error(e.message) or simply do nothing
  end

end