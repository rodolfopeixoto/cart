
//getUser

  function getUser(url){
    return url.match(/\d/)
  }


// AddCart
$(window).load(function() {
  return $('a[data-target]').click(function(e) {
    var $this, new_target, url, id_user, quantity;
    quantity = $('input#product_quantity').val();
    e.preventDefault();
    $this = $(this);
 
     url = $this.data('addurl');
    

    id_user = getUser(url);
    return $.ajax({
      url: '/cart/add/'+id_user+'/'+quantity,
      type: 'put',
      success: function(data) {
        $('.cart-count').html(data);
      }
    });
  });
  
});


// Remove Cart

$(window).load(function() {
  return $('#mycart .fi-x').click(function(e) {
    var $this, url;
    e.preventDefault();
    $this = $(this).closest('a');
    url = $this.data('targeturl');
    return $.ajax({
      url: url,
      type: 'put',
      success: function(data) {
        $('.cart-count').html(data);
        return $this.closest('.cart-movie').slideUp();
      }
    });
  });
});