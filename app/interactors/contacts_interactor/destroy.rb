module ContactsInteractor

  # Context parameters
  # id: integer
  class Destroy
    include Interactor

    def call
      contact = Contact.where(id: context.id).first
      if contact
        context.deleted = contact.id
        contact.delete
      else
        context.fail! errors: ["Contact not found with id: #{context.id}"]
      end
    end

  end
end