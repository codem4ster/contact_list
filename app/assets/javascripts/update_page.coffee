class window.UpdatePage
  
  constructor: ()->
    @form = $('.update-page form')
    @name = $('#contact_name')
    @last_name = $('#contact_last_name')
    @phone = $('#contact_phone')
    
  render: ()->
    @load_values()
    
  load_values: ()->
    self = @
    id = self.form.attr('data-id')
    $.ajax '/contacts/'+id, {
      type: 'GET',
      dataType: 'json',
      data: {},
      success: (response)->
        self.name.val(response['contact']['name'])
        self.last_name.val(response['contact']['last_name'])
        self.phone.val(response['contact']['phone'])
      error: (response)->
        alert(response['errors'][0])
    }
    
    