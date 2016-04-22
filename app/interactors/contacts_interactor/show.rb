module ContactsInteractor

  # Context parameters
  # id: integer
  class Show
    include Interactor

    def call
      contact = Contact.where(id: context.id).first
      if contact
        context.contact = contact.decorate if contact
      else
        context.fail! errors: ["Contact not found with id: #{context.id}"]
      end
    end

  end
end