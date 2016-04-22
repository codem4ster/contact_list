module ContactsInteractor

  # Context parameters must be
  # name: string
  # last_name: string
  # phone: string
  class Create
    include Interactor

    def call
      contact = Contact.new context.to_h
      if contact.valid?
        contact.save
        context.contact = contact
      else
        context.fail! errors: contact.errors.full_messages
      end
    end

  end
end