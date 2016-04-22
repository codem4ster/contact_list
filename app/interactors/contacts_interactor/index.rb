module ContactsInteractor

  # Context parameters must be
  # page: string
  class Index
    include Interactor

    def validate_page
      if context.page.to_i.to_s != context.page.to_s
        context.fail! errors: ['Page parameter is invalid']
      end
    end

    def call
      context.page ||= 1
      validate_page
      contacts = Contact.page(context.page.to_i)
      context.contacts = contacts.decorate
      context.pagination = Pagination.new(contacts).decorate
    end

  end
end