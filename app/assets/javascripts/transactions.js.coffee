#$total = new Transaction($('#selected-products-total'))

load_search_products = ->
  $product_typeahead = $('input.search-products').typeahead
    name: 'products'
    remote: '/products.json?q=%QUERY'
    template: $('#tpl_product').html()
    engine: Hogan
    valueKey: 'name'

  $product_typeahead.on 'typeahead:selected', (evt, data) ->
    $(@).data('name', data.name)
    $(@).data('price', data.price)

jQuery ->
  $('span.number').number(true, 2)

  $(document).on 'click', '#add-product', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    $selected_products = $('#selected-products')
    $product_name = $('#product_name')
    $product_quantity = $('#product_quantity')
    $product_total = $('#selected-products-total')
    data =
      sequence: $selected_products.find('tbody tr').length + 1
      name: $product_name.data('name')
      price: $product_name.data('price')
      quantity: $product_quantity.val()
      total: $product_quantity.val() * $product_name.data('price')
    template = Hogan.compile($('#tpl_product_list').html())
    html = template.render(data)
    $selected_products.find('tbody').append(html)
    $product_total.html(parseFloat($product_total.text()) + parseFloat(data['total']))
    e.preventDefault()

  $(document).on 'click', '.show-product-form', (e) ->
    new_id = new Date().getTime()
    template = Hogan.compile $('#tpl_product_form').html()
    html = template.render({ id: new_id })
    $('#fields-for-product').html(html).toggle()
    $('#fields-add-product').toggle()
    load_search_products()
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

  load_search_products()

class Transaction
  constructor: (@input) ->
    @reset()
    @show_total()

  add: (subtotal) ->
    @total = @total + subtotal
    @show_total()

  reset: =>
    @total = 0

  show_total: =>
    @input.html(@total)
