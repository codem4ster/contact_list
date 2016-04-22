module ContactsInteractor

  # Context parameters might be
  # id: integer
  # name: string
  # last_name: string
  # phone: string
  class Update
    include Interactor

    def call
      @contact = Contact.where(id: context.id).first
      if @contact
        update_contact
      else
        context.fail! errors: ["Contact not found with id: #{context.id}"], status: 404
      end
    end

    def update_contact
      @contact.attributes = context.to_h.slice(:name, :last_name, :phone)
      if @contact.valid?
        @contact.save
        context.contact = @contact
      else
        context.fail! errors: @contact.errors.full_messages, status: 400
      end
    end

  end
end