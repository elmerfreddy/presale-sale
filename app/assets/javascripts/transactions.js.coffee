products_json = ->
  products = []

jQuery ->
  $(document).on 'click', '#add-product', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()

  $(document).on 'click', '.show-product-form', (e) ->
    new_id = new Date().getTime()
    template = Hogan.compile $('#tpl_product_form').html()
    html = template.render({ id: new_id, products: products_json() })
    $('#fields-for-product').html(html).toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()

  $store_typeahead = $('input.search-stores').typeahead
    name: 'stores'
    remote: '/stores.json?q=%QUERY'
    template: $('#tpl_store').html()
    engine: Hogan
    valueKey: 'name'

  $store_typeahead.on 'typeahead:selected', (evt, data) ->
    $container = $('#selected-products').find('>h2')
    $container.html(data.name)
    $container.removeClass('muted')

  $product_typeahead = $('input.search-products').typeahead
    name: 'products'
    remote: '/products.json?q=%QUERY'
    template: $('#tpl_product').html()
    engine: Hogan
    valueKey: 'name'

  $product_typeahead.on 'typeahead:selected', (evt, data) ->
    console.log data.id
