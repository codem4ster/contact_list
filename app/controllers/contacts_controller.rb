class ContactsController < ApiController
  def create
    args = params.require(:contact).permit(:name, :last_name, :phone)
    result = ContactsInteractor::Create.call args
    if result.success?
      render json: {created: result.contact.id}
    else
      render json: {errors: result.errors}, status: 400
    end
  end

  def update
    contact = params.require(:contact).permit(:name, :last_name, :phone)
    args = {id: params[:id]}.merge contact
    result = ContactsInteractor::Update.call args
    if result.success?
      render json: {updated: result.contact.id}
    else
      render json: {errors: result.errors}, status: result.status
    end
  end

  def index
    args = params.permit(:page)
    result = ContactsInteractor::Index.call args
    if result.success?
      render json: {contacts: result.contacts, pagination: result.pagination}
    else
      render json: {errors: result.errors}, status: 400
    end
  end

  def show
    args = params.permit(:id)
    result = ContactsInteractor::Show.call args
    if result.success?
      render json: {contact: result.contact}
    else
      render json: {errors: result.errors}, status: 404
    end
  end

  def destroy
    args = params.permit(:id)
    result = ContactsInteractor::Destroy.call args
    if result.success?
      render json: {deleted: result.deleted}
    else
      render json: {errors: result.errors}, status: 404
    end
  end

  def import_from_file
    file_handle = params.require(:importer).permit(:file)[:file]
    content = file_handle.tempfile.read
    file_handle.tempfile.close(true)
    args = {
      importer: XmlContactImporter,
      content: content
    }
    result = ContactsInteractor::ImportWithString.call args
    if result.success?
      render json: {total: result.total, imported: result.imported, not_imported: result.not_imported}
    else
      render json: {errors: result.errors}, status: 400
    end
  end
end
