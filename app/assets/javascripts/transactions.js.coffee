jQuery ->
  $(document).on 'click', '#add-product', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()

  $(document).on 'click', '.show-product-form', (e) ->
    $('#fields-for-product').toggle()
    $('#fields-add-product').toggle()
    e.preventDefault()
