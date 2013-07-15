products_json = ->
  products = []

jQuery ->
  $(document).on 'click', '#add-product', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()

  $(document).on 'click', '.show-product-form', (e) ->
    new_id = new Date().getTime()
    template = Hogan.compile $('#tpl_product').html()
    html = template.render({ id: new_id, products: products_json() })
    $('#fields-for-product').html(html).toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()
