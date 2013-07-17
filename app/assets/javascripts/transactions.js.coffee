class Transaction
  constructor: ->
    @store = null
    @products = new Array()

  add: (product) ->
    prod = @search_product(product)
    if prod
      prod.quantity = prod.quantity + product.quantity
      @show_product_list(prod)
    else
      @products.push(product)
      @show_product_list(product)
    @show_total()

  search_product: (product) =>
    for p in @products
      if p.id is product.id
        return p
    return null

  show_product_list: (product) =>
    dom_id = "#product_#{product.id}"
    template = Hogan.compile($('#tpl_product_list').html())
    html = template.render(product)
    if $(dom_id).length > 0
      $(dom_id).replaceWith(html)
    else
      $('#selected-products').find('tbody').append(html)

  show_total: =>
    $input = $('#selected-products-total')
    $input.html("$#{$.number(@total(), 2)}")

  total: =>
    t = 0.0
    for p in @products
      t = t + p.total()
    t

class Product
  constructor: (data) ->
    @id = data.id
    @name = data.name
    @price = $.number(data.price, 2)
    @quantity = 0

  total: =>
    $.number(@price * @quantity, 2)

$transaction = new Transaction()
$product = null

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
    $product = new Product(data)

jQuery ->
  $('span.number').number(true, 2)

  $(document).on 'click', '#add-product', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    if $product
      $product.quantity = parseInt($('#product_quantity').val() || 0)
      $transaction.add($product)
    else
      console.log 'No se ha seleccionado un producto'
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
