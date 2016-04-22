module ContactsInteractor

  # Context parameters
  # importer: kind of ContactImporter
  # content: string
  class ImportWithString
    include Interactor

    def call
      @importer = context.importer.new(context.content)
      @importer.import
      context.total = @importer.total
      context.imported = @importer.imported
      context.not_imported = @importer.not_imported
    rescue ContactImporterException => e
      context.fail! errors: [e.message]
    end

  end

end