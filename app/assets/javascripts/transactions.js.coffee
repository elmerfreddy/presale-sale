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
      price: $.number($product_name.data('price'), 2)
      quantity: $product_quantity.val()
      total: $.number($product_quantity.val() * $product_name.data('price'), 2)
    template = Hogan.compile($('#tpl_product_list').html())
    html = template.render(data)
    $selected_products.find('tbody').append(html)
    total = parseFloat($product_total.text()) + parseFloat(data['total'])
    $product_total.html($.number(total, 2))
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

  $(document).on 'click', '.remove-product', (e) ->
    $(@).closest('tr').remove()
    e.preventDefault()

  $(document).on 'click', '.edit-product', (e) ->
    e.preventDefault()

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
