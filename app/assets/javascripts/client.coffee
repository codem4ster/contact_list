$.ajaxSetup dataType: 'json'


$(document).on "page:change", ->
  $('form[name="importer"]').on 'ajax:success', (e, data, status, xhr)->
    alert('kişiler başarıyla yüklendi')
  $('form[name="importer"]').on 'ajax:error', (e, data, status, xhr)->
    response = data.responseJSON
    alert(response['errors'][0])

  contact_form = $('form[name="contact"]')
  contact_form.on 'ajax:success', (e, data, status, xhr)->
    if data['created']
      alert('Contact has been created')
    else if data['updated']
      alert('Contact has been updated')
  contact_form.on 'ajax:error', (e, data, status, xhr)->
    response = data.responseJSON
    alert(response['errors'][0])

  # index page
  if $('#contact-table').length > 0
    index_page = new window.IndexPage
    index_page.render()

  # update page
  if $('.update-page').length > 0
    index_page = new window.UpdatePage
    index_page.render()