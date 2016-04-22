class window.IndexPage

  constructor: ()->
    @contact_table = $('#contact-table')
    @table_body = @contact_table.find('tbody')
    @pagination = $('.paginate-btn')
    @first_btn = $('.paginate-btn.first')
    @previous_btn = $('.paginate-btn.previous')
    @next_btn = $('.paginate-btn.next')
    @last_btn = $('.paginate-btn.last')
    @current_page = $('.current-page')
    return

  load_page: (page)->
    self = @
    $.ajax '/contacts', {
      type: 'GET',
      dataType: 'json',
      data: { page: page },
      success: (response)->
        self.clear_table()
        self.render_table(response['contacts'])
        self.render_pagination(response['pagination'])
      error: (response)->
        alert(response['errors'][0])
    }

  clear_table: ()->
    @table_body.html ''

  render_pagination: (data)->
    @first_btn.attr('data-page': 1)
    @previous_btn.attr('data-page': data['prev_page'])
    @next_btn.attr('data-page': data['next_page'])
    @last_btn.attr('data-page': data['total_pages'])
    @current_page.text(data['current_page'])
    if data['current_page'] == 1
      @first_btn.prop( "disabled", true )
      @previous_btn.prop( "disabled", true )
    else
      @first_btn.prop( "disabled", false )
      @previous_btn.prop( "disabled", false )
    if data['current_page'] == data['total_pages']
      @next_btn.prop( "disabled", true )
      @last_btn.prop( "disabled", true )
    else
      @next_btn.prop( "disabled", false )
      @last_btn.prop( "disabled", false )

  render_table: (data)->
    self = @
    $.each data, (i, item) ->
      tr = $("<tr data-id=\"#{item['id']}\">").append(
        $('<td>').text(item['name']),
        $('<td>').text(item['last_name']),
        $('<td>').text(item['phone']),
        $('<td>').html('' +
            '<button class="btn btn-info edit-btn">' +
              '<span class="glyphicon glyphicon-edit"></span>' +
            '</button>' +
            '<button class="btn btn-danger delete-btn">' +
              '<span class="glyphicon glyphicon-trash"></span>' +
            '</button>')
      )
      tr.appendTo self.table_body

  delete_contact: (id)->
    self = @
    $.ajax '/contacts/'+id, {
      type: 'DELETE',
      dataType: 'json',
      data: {},
      success: (response)->
        alert 'Record has been deleted'
        self.load_page(self.current_page.text())
      error: (response)->
        alert(response['errors'][0])
    }

  render: ()->
    self = @
    @pagination.on('click', (evt)->
      page = $(evt.currentTarget).attr('data-page')
      self.load_page page
    )
    @table_body.on('click', '.edit-btn', (evt)->
      id = $(evt.currentTarget).parents('tr').attr('data-id')
      window.location.href = '/edit?id='+id
    )
    @table_body.on('click', '.delete-btn', (evt)->
      id = $(evt.currentTarget).parents('tr').attr('data-id')
      if confirm('Are you sure?')
        self.delete_contact(id)
    )
    @load_page(1)