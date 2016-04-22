class ContactImporter

  attr_reader :total, :imported, :not_imported

  def initialize(content)
    @content = content
    @imported = 0
    @total = 0
    @not_imported = 0
  end

  def import
    raise NotImplementedError
  end

end